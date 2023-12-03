# 놓치고 있던 내용 정리

### OCP 위반
```java
public class OrderServiceImpl implements OrderService {
    
    

    // 의존성 직접 주입 -> 구현 클래스에 의존, OCP 위반
    private final DiscountPolicy discountPolicy = new FixDiscountPolicy();
    private final DiscountPolicy discountPolicy = new RateDiscountPolicy();

}

```

### final의 사용
```java
public class MemberServiceImpl implements MemberService {
  1)  private final MemberRepository memberRepository;
  2)  private MemberRepository memberRepository;

    public MemberServiceImpl(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }
    ...
}
```

* final을 붙이는 이유는 생성자를 통해 최초로 필드에 의존성 주입이 이뤄지면 그 이후부터는 변경 불가 상태를 만들기 위함이다.
* 만약 2번처럼 사용하게 되면 생성자 주입으로 필드에 의존성을 할당해도 추후에 언제든지 필드 주입으로 변경가능하다.

### spring bean 주입과 같은 역할
```java
public class OrderApp {

    public static void main(String[] args) {

        AppConfig appConfig = new AppConfig(); // appConfig(외부)에서 결정, 빈 주입

        MemberService memberService = appConfig.memberService();
        OrderService orderService = appConfig.orderService();

        Long memberId = 1L;
        Member member = new Member(memberId, "황원용", Grade.VIP);
        memberService.join(member);

        Order order = orderService.createOrder(memberId, "루이비통", 10000);

        System.out.println("order = " + order);
        System.out.println("order.calculatePrice() = " + order.calculatePrice());
    }
}
```

### SOLID 원칙을 지키는 AppConfig
```java
public class AppConfig {

    public MemberService memberService() {
        return new MemberServiceImpl(memberRepository());
    }

    private static MemberRepository memberRepository() {
        return new MemoryMemberRepository();
    }

    public OrderService orderService() {
        return new OrderServiceImpl(memberRepository(), discountPolicy());
    }

    private static DiscountPolicy discountPolicy() {
        return new FixDiscountPolicy();
    }
}
```
#### SRP 단일 책임원칙
* 클라이언트 객체는 비즈니스 로직만 실행
* 구현 객체를 생성하고 연결하는 책임은 AppConfig가 함
#### DIP 의존관계 역전 원칙
* 클라이언트 코드는 추상화(인터페이스)에만 의존한다. 구체 클래스에는 의존하지 않는다.
#### OCP 개방 폐쇄 원칙
* AppConfig에서 의존관계를 변경하여 다형성을 사용함
* 이후 클라이언트 코드에 의존성 주입, 이때 클라이언트 코드는 변경되지 않음
  * 확장에는 열려있으나, 변경에는 닫혀있어야 한다는 OCP 충족

---

### 스프링 컨테이너
* `ApplicationContext` 를 스프링 컨테이너라고 함
* 스프링 컨테이너는 `@Configuration` 이 붙은 `AppConfig` 를 설정 정보로 사용한다. 
* 여기서 `@Bean` 이 라 적힌 메서드를 모두 호출해서 반환된 객체를 스프링 컨테이너에 등록한다. 
* 이렇게 스프링 컨테이너에 등록된 객체를 스프링 빈이라고 함
  * 스프링 빈을 등록하는 방법은 직접 등록하는 방법과 AppConfig와 같이 팩토리 빈으로 등록하는 방법이 있다.

### BeanFactory
- 스프링 컨테이너의 최상위 인터페이스이다.
- 스프링 빈을 관리하고 조회하는 역할을 담당한다.
- `getBean()`을 제공한다.
- 실무에서 사용하는 스프링의 기능 대부분은 BeanFactory가 제공하는 기능이다. 

### ApplicationContext
- BeanFactory 기능을 모두 상속받아 제공한다.
- 이외에도 수많은 부가기능을 가지고 있다.
  - 메시지 소스를 활용한 국제화 기능, 환경변수, 애플리케이션 이벤트, 리소스 조회
- BeanFactory을 직접 사용하지 않고 보통은 ApplicationContext를 사용한다.

### 스프링 빈 메타 정보 - BeanDefinition
- 스프링이 자바 코드나, XML 등 다양한 설정 형식을 지원할 수 있는 이유는 BeanDefinition 때문이다.
- 스프링 컨테이너 입장에서는 자바 코드인지, XML인지 몰라도 된다. BeanDefinition만 알면 장땡이다.
  - 다양한 설정 형식을 읽어 BeanDefinition으로 만들면 된다!
- BeanDefinition을 직접 생성하여 스프링 컨테이너에 등록할 수 있다. 스프링 코드나 관련 오플 소스에 BeanDefinition에 대한 정보가 나오면 이 메커니즘을 떠올리자.

#### BeanDefinition 정보
- beanClassName : 생성할 빈의 클래스 명(자바 설정처럼 팩토리 역할의 빈을 사용하면 없음)
- factoryBeanName : 팩토리 역할의 빈을 사용할 경우 이름(ex. appConfig)
- factoryMethodName : 빈을 생성할 팩토리 메서드 지정,(ex. memberService)
- scope : 싱글톤(기본값)
- lazyInit : 스프링 컨테이너를 생성할 때 빈을 생성하는 것이 아니라, 실제 빈을 사용할 때까지 최재한 생성을 지연처리하는지의 여부
- initMethodName : 빈을 생성하고, 의존관계를 적용한 뒤에 호출되는 초기화 메서드 명
- destoryMethodName: 빈의 생명주기가 끝나서 제거하기 직전에 호출되는 메서드 명
- constructor arguments, properties : 의존 관계 주입에서 사용(자바 설정처럼 팩토리 역할의 빈을 사용하면 없음)
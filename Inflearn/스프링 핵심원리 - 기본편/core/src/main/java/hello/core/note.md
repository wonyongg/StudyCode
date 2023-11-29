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

### 스프링 컨테이너
* `ApplicationContext` 를 스프링 컨테이너라고 함
* 스프링 컨테이너는 `@Configuration` 이 붙은 `AppConfig` 를 설정 정보로 사용한다. 
* 여기서 `@Bean` 이 라 적힌 메서드를 모두 호출해서 반환된 객체를 스프링 컨테이너에 등록한다. 
* 이렇게 스프링 컨테이너에 등록된 객체를 스프링 빈이라고 함
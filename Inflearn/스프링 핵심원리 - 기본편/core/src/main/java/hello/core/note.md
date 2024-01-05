# 놓치고 있던 내용 정리

### OCP 위반
```java
public class OrderServiceImpl implements OrderService {
    
    

    // 의존성 직접 주입 -> 구현 클래스에 의존, OCP 위반
    private final DiscountPolicy discountPolicy = new FixDiscountPolicy();
    private final DiscountPolicy discountPolicy = new RateDiscountPolicy();

}

```
<br><br>

### final의 사용
```java
public class MemberServiceImpl implements MemberService {
  // 1)  private final MemberRepository memberRepository;
  // 2)  private MemberRepository memberRepository;

    public MemberServiceImpl(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }
    ...
}
```

* final을 붙이는 이유는 생성자를 통해 최초로 필드에 의존성 주입이 이뤄지면 그 이후부터는 변경 불가 상태를 만들기 위함이다.
* 만약 2번처럼 사용하게 되면 생성자 주입으로 필드에 의존성을 할당해도 추후에 언제든지 필드 주입으로 변경가능하다.

<br><br>

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
<br><br>

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

<br><br>

### BeanFactory
- 스프링 컨테이너의 최상위 인터페이스이다.
- 스프링 빈을 관리하고 조회하는 역할을 담당한다.
- `getBean()`을 제공한다.
- 실무에서 사용하는 스프링의 기능 대부분은 BeanFactory가 제공하는 기능이다. 

<br><br>

### ApplicationContext
- BeanFactory 기능을 모두 상속받아 제공한다.
- 이외에도 수많은 부가기능을 가지고 있다.
  - 메시지 소스를 활용한 국제화 기능, 환경변수, 애플리케이션 이벤트, 리소스 조회
- BeanFactory을 직접 사용하지 않고 보통은 ApplicationContext를 사용한다.

<br><br>

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

---
### 싱글톤 컨테이너
```java
 public class AppConfig {
     public MemberService memberService() {
         return new MemberServiceImpl(memberRepository());
}
     public OrderService orderService() {
         return new OrderServiceImpl(
                 memberRepository(),
                 discountPolicy());
}
     public MemberRepository memberRepository() {
         return new MemoryMemberRepository();
}
     public DiscountPolicy discountPolicy() {
         return new FixDiscountPolicy();
}
}
```
- 순수한 DI 컨테이너는 요청시마다 객체를 새로 생성함
- 만약 트랙픽이 초당 100번 발생하면 말그대로 초당 100 개의 객체가 생성되고 소멸된다.
  - 이는 메모리 낭비가 매우 심하다.
- 객체를 한 개만 생성하고 이를 공유하도록 설계하여 문제를 해결할 수 있다. -> 싱글톤 패턴

<br><br>

#### 싱글톤 패턴
```java
public class SingletonService {

    //1. static 영역에 객체를 딱 한개만 생성해둔다.
    private static final SingletonService instance = new SingletonService();

    //2. public으로 열어서 객체 인스턴스가 필요하면 이 static 메서드를 통해서만 조회하도록 허용한다.
    public static SingletonService getInstance() {
        return instance;
    }

    //3. 생성자를 private으로 선언하여 외부에서 new 키워드를 사용한 객체 생성을 막는다.
    private SingletonService() {}

    public void logic() {
        System.out.println("싱글톤 객체 로직 호출");
    }
}
```

#### 싱글톤 패턴의 문제점
- 싱글톤 패턴을 구현하는데 코드가 많이 필요하다.
- 의존관계에서 클라이언트가 구체 클래스에 의존한다. -> DIP 위반, OCP 위반
- 테스트가 어렵다.
- 내부 속성을 변경하거나 초기화하기 어렵다
- private 생성자로 자식 클래스를 만들기 어렵다.

#### 스프링의 싱글톤 컨테이너
- 싱글턴 패턴을 따로 구현하지 않아도 객체 인스턴스를 싱글톤으로 관리한다.
- 싱글톤 패턴의 문제점인 코드의 지저분함, DIP, OCP 위반, private 생성자로부터 자유로워진다.

#### 싱글톤 패턴에서 주의해야 할 점
- 하나의 객체 인스턴스를 여러 클라이언트가 공유하여 사용하므로 stateful하게 설계하면 안된다.(stteless하게 설계해야 한다.)
  - 특정 클라이언트에 의존적인 필드가 있으면 안된다.
  - 특정 클라이언트가 값을 변경할 수 있는 필드가 있어서는 안된다.
  - 가급적 읽기만 가능해야 한다.(read only)
  - 필드 대신에 자바에서 공유되지 않는 지역변수, 파라미터, ThreadLocal 등을 사용해야 한다.
  - 스프링 빈의 필드에 공유 값을 설정하면 큰 장애가 발생할 수 있다.
    ```java
    void statefulServiceSingleton() {
        AnnotationConfigApplicationContext ac = new AnnotationConfigApplicationContext(TestConfig.class);
        StatefulService statefulService1 = ac.getBean(StatefulService.class);
        StatefulService statefulService2 = ac.getBean(StatefulService.class);
  
        // ThreadA: A 사용자 10000원 주문
        statefulService1.order("userA",10000);
  
        // ThreadA: B 사용자 20000원 주문
        statefulService2.order("userB",20000);
  
        //ThreadA: 사용자 A 주문 금액 조회
        int price = statefulService1.getPrice();
  
        System.out.println("price = " + price);
  
        Assertions.assertThat(statefulService1.getPrice()).isEqualTo(20000); // true
    }
    ```
---

### @Configuration
```java
  @Configuration
public class AppConfig {

  @Bean
  public MemberService memberService() {
    System.out.println("call AppConfig.memberService");
    return new MemberServiceImpl(memberRepository());
  }

  @Bean
  public MemberRepository memberRepository() {
    System.out.println("call AppConfig.memberRepository");
    return new MemoryMemberRepository();
  }

  @Bean
  public OrderService orderService() {
    System.out.println("call AppConfig.orderService");
    return new OrderServiceImpl(memberRepository(), discountPolicy());
  }

  @Bean
  public DiscountPolicy discountPolicy() {
    return new FixDiscountPolicy();
  }
}
```
- AppConfig를 보면 memberService()와 orcerService() 빈을 만들 때 각각 memberRepository()를 호출한다.
- 그럼 new MemoryMemberRepository()가 반환될텐데 그렇다면 2 개의 MemoryMemberRepository가 생성되어 싱글톤이 깨지지 않을까?
  ```java
    void configurationTest() {
        AnnotationConfigApplicationContext ac = new AnnotationConfigApplicationContext(AppConfig.class);

        MemberServiceImpl memberService = ac.getBean("memberService", MemberServiceImpl.class);
        OrderServiceImpl orderService = ac.getBean("orderService", OrderServiceImpl.class);
        MemberRepository memberRepository = ac.getBean("memberRepository", MemberRepository.class);

        MemberRepository memberRepository1 = memberService.getMemberRepository();
        MemberRepository memberRepository2 = orderService.getMemberRepository();

        System.out.println("memberService -> memberRepository = " + memberRepository1);
        System.out.println("orderService -> memberRepository = " + memberRepository2);
        System.out.println("memberRepository = " + memberRepository);

        Assertions.assertThat(memberService.getMemberRepository()).isSameAs(orderService.getMemberRepository());
        Assertions.assertThat(memberRepository).isSameAs(orderService.getMemberRepository());
  
        // call AppConfig.memberService
        // call AppConfig.memberRepository
        // call AppConfig.orderService
        // memberService -> memberRepository = hello.core.member.MemoryMemberRepository@5aa360ea
        // orderService -> memberRepository = hello.core.member.MemoryMemberRepository@5aa360ea
        // memberRepository = hello.core.member.MemoryMemberRepository@5aa360ea
    }
  ```
- 분명히 memberRepository는 3번 호출되어야 정상일텐데 한 번 밖에 호출되지 않았다.
- 놀랍게도 모두 같은 인스턴스를 공유하여 사용하고 있다.
- 스프링 빈이 싱글톤이 되도록 보장해주고 있는 것이다.

<br><br>
```java
      void configurationDeep() {
        AnnotationConfigApplicationContext ac = new AnnotationConfigApplicationContext(AppConfig.class);
        AppConfig bean = ac.getBean(AppConfig.class);

        System.out.println("bean = " + bean.getClass());
      }
      
      // bean = class hello.core.AppConfig$$SpringCGLIB$$0
```
- AnnotationConfigApplicationContext` 에 파라미터로 넘긴 값은 스프링 빈으로 등록된다.
- 따라서 Appconfig도 스프링 빈으로 등록된다.
- 순수한 클래스라면 `class hello.core.AppConfig`와 같이 출력되어야 한다.
- 그러나 클래스명에 CGLIB과 같은 것이 붙으면 복잡해졌다.
- 이는 스프링이 내가 만든 클래스를 상속받은 임의의 다른 클래스를 만들고 이 클래스를 스프링 빈으로 등록하여 생긴 것이다.
  - 이 클래스가 바로 싱글톤을 보장해주는 비밀이다.
  ```java
  @Bean
  public MemberRepository memberRepository() {
    if (memoryMemberRepository가 이미 스프링 컨테이너에 등록되어 있으면?) { return 스프링 컨테이너에서 찾아서 반환;
    }
    else { //스프링 컨테이너에 없으면
    기존 로직을 호출해서 MemoryMemberRepository를 생성하고 스프링 컨테이너에 등록 return 반환
    }
  }
  ```
  - 아마도 이런 식으로 스프링 빈이 존재하는지를 체크하여 없으면 생성하고 있다면 찾아서 반환해주는 방식으로 싱글톤을 보장할 것이다.
  - 이 CGLIB 기술을 사용하는 것이 바로 @Configuration이며, 만약 해당 애너테이션을 제거하면 @Bean으로 인해 스프링 빈으로는 등록되지만 싱글톤은 보장하지 않게 된다.

---

## @ComponentScan & @Autowired
### @ComponentScan
- 스프링 빈을 @Bean 애너테이션이나 XML 등을 통해 직접 등록할 수 있지만, 등록해야 할 빈이 수십객가 넘어가면 누락될 문제가 발생할 수도 있고, 일일이 등록하기도 힘들다.
- 스프링에서는 설정 정보를 따로 주지 않아도 자동으로 스프링 빈을 등록하는 컴포넌트 스캔이라는 기능을 제공한다.
- @ComponentScan은 @Component가 붙은 모든 클래스를 스프링 빈으로 등록한다.
- 이떄 자동으로 등록되는 스프링 빈의 기본 이름은 클래스 명에 맨 앞글자를 소문자로 하여 만들어진다.

### 컴포넌트 스캔의 탐색 위치와 기본 탐색 대상

```java
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(
        basePackages = "hello.core"
)
```
- `basePackages`
  - 탐색할 패키지의 시작 위치를 지정할 수 있다.
- {} 안에 여러 패키지를 한 번에 지정할 수 있다.
- `basePackageClasses` : 지정한 클래스의 패키지를 탐색 시작 위치로 지정한다.
- ```java
    @Target(ElementType.TYPE)
    @Retention(RetentionPolicy.RUNTIME)
    @Documented
    @Inherited
    @SpringBootConfiguration
    @EnableAutoConfiguration
    @ComponentScan(excludeFilters = { @Filter(type = FilterType.CUSTOM, classes = TypeExcludeFilter.class),
    @Filter(type = FilterType.CUSTOM, classes = AutoConfigurationExcludeFilter.class) })
    public @interface SpringBootApplication { ... }
  ```
  - 스프링 부트는 기본적으로 프로젝트 최상단에 위치한 클래스(XXXApplication)에 @SpringBootApplication 애너테이션을 통해 컴포넌트 스캔을 적용한다.
    - @SpringBootApplication 안에 @ComponentScan이 있다.
    - 프로젝트 최상단 위치에서부터 탐색을 시작하게 된다.
  - includeFilters는 컴포넌트 스캔 대상을 추가로 지정한다.
  - excludeFilters는 컴포넌트 스캔에서 제외할 대상을 지정한다.

<br><br>

### @Autowired
- 생성자에 @Autowired를 지정하면, 스프링 컨테이너가 자동으로 해당 스프링 빈을 찾아 주입한다.

### 자동 빈 등록 vs 수동 빈 등록
- 스프링 부트에서는 자동, 수동 빈 등록이 충돌나면 에러가 발생하게 된다.
- application 설정에
  spring.main.`allow-bean-definition-overriding=true`를 추가하게 되면 수동으로 등록한 빈이 우선되어 등록된다.

---
## 다양한 의존관계 주입 방법
```java
@Component
public class OrderServiceImpl implements OrderService {
    private final MemberRepository memberRepository; // final로 불변 보장
    private final DiscountPolicy discountPolicy;
    
    @Autowired // 생성자로 필수 보장
    public OrderServiceImpl(MemberRepository memberRepository, DiscountPolicy
            discountPolicy) {
      this.memberRepository = memberRepository;
      this.discountPolicy = discountPolicy;
    }
}
```

```java
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor // 이거 하나로 위와 동일
public class OrderServiceImpl implements OrderService {
  private final MemberRepository memberRepository; // final로 불변 보장
  private final DiscountPolicy discountPolicy;
}
```
- 생성자 주입
  - 생성자를 통해 의존 관계를 주입받는다.
  - 생성자 호출 시점에 딱 1번만 호출되는 것이 보장된다.
  - 불변하며 필수적인 의존관계에 사용된다.
    - 대부분 불변하며 필수적이어야 하기 때문에 그냥 생성자 주입을 쓰면 된다.
<br><br>
- 수정자 주입(setter 주입)
  - 선택, 변경 가능성이 있는 의존관계에 사용
  - 가끔 필요한 경우 사용할 수 있다.
- 필드 주입
  - 외부에서 변경이 불가능하다.
  - DI 프레임워크가 없으면 아무것도 할 수 없다.
  - 사용하지 않는 것이 좋다.
- 일반 메서드 주입
  - 한번에 여러 필드를 주입받을 수 있다.
  - 생성자 주입을 사용하고 일반 메서드 주입은 잘 사용하지 않는다.




## 조회 빈이 2 개 이상일 때 해결 방법
### @Autowired

```java
@Component
public class OrderServiceImpl implements OrderService {

  private final MemberRepository memberRepository;
  @Autowired
  private final DiscountPolicy rateDiscountPolicy;

  @Autowired
  public OrderServiceImpl(MemberRepository memberRepository, DiscountPolicy rateDiscountPolicy) {
    this.memberRepository = memberRepository;
    this.discountPolicy = rateDiscountPolicy;
  }
```
- 타입 매칭의 겨로가가 2개 이상일 경우 필드명이나 파라미터 명으로 빈 이름을 매칭한다.

### @Qualifier

```java
@Component
@Qualifier("rateDiscountPolicy")
public class RateDiscountPolicy implements DiscountPolicy {}
```
```java
  @Autowired 
  public OrderServiceImpl(MemberRepository memberRepository, DiscountPolicy discountPolicy) {
    this.memberRepository = memberRepository;
    this.discountPolicy = discountPolicy;
  }
```
- @Qualifier끼리 매칭한다.
- 만약, 찾지 못하면 빈 이름으로 매칭한다.
- 그래도 못찾으면 NoSuchBeanDefinitionException 예외가 발생한다.

### @Primary
- 우선순위를 정할 수 있어 @Primary 애너테이션이 붙은 빈이 우선권을 가진다. 

### @Primary, @Qualifier 활용
- 메인을 사용하는 스프링 빈에 @primary를 적용하고 특별히 혹은 가끔 사용하는 서브 스프링 빈에 @Qualifier를 사용하면 된다.
- 둘 중의 우선순위는 좀 더 구체적으로 적용하는 @Qualifier가 더 높다.

---

## 애너테이션 만들기
```java
 package hello.core.annotataion;
 import org.springframework.beans.factory.annotation.Qualifier;
 import java.lang.annotation.*;
 @Target({ElementType.FIELD, ElementType.METHOD, ElementType.PARAMETER,
 ElementType.TYPE, ElementType.ANNOTATION_TYPE})
 @Retention(RetentionPolicy.RUNTIME)
 @Documented
 @Qualifier("MainDiscountPolicy")
 public @interface MainDiscountPolicy {
}
```
- @Qualifier("mainDiscountPolicy)라고 적는건 타입 체크가 불가능하기 때문에 애너테이션을 만들어서 문제를 해결할 수 있다.

---

## 조회한 빈이 모두 필요할 때(List, Map)
```java
public class AllBeanTest {
    @Test
    void findAllBean() {
        ApplicationContext ac = new AnnotationConfigApplicationContext(AutoAppConfig.class, DiscountService.class);
        DiscountService discountService = ac.getBean(DiscountService.class);
        Member member = new Member(1L, "userA", Grade.VIP);
        
        int discountPrice = discountService.discount(member, 10000, "fixDiscountPolicy");
        
        assertThat(discountService).isInstanceOf(DiscountService.class);
        assertThat(discountPrice).isEqualTo(1000);
    }
    
    static class DiscountService {
        
        private final Map<String, DiscountPolicy> policyMap;
        private final List<DiscountPolicy> policies;
        
        public DiscountService(Map<String, DiscountPolicy> policyMap, List<DiscountPolicy> policies) {
            this.policyMap = policyMap;
            this.policies = policies;
        }
        
        public int discount(Member member, int price, String discountCode) {
            DiscountPolicy discountPolicy = policyMap.get(discountCode);
            
            return discountPolicy.discount(member, price);
        } 
    }
}
```
- 의도적으로 특정 타입의 스프링 빈이 다 필요한 경우가 있을 수 있다.
- 예를 들어 할인 서비스를 제공하는데 할인의 종류를 클라이언트가 고른다거나 하는 경우이다.(고정할인, 비율할인)
- 로직 설명
  - DiscountService에서 해당 빈을 Map or List로 모두 가지고 있다.
  - 고객이 요청을 보낼 때 특정 할인 정책을 구분하는 파라미터 값을 함께 보낸다.
  - 해당하는 정책을 Map이나 List에서 꺼내어 적용한 할인 값을 리턴한다.(discount 메서드)

---

## 빈 생명주기 콜백
- 데이터베이스의 커넥션 풀이나 네트워크 소켓처럼 애플리케이션이 시작할 시점에 필요한 연결을 미리 해두고, 애플리케이션이 종료할 시점에 연결을 모두 종료하는 작업이 필요할 때가 있다.
  - 이때 객체의 초기화와 종료 작업이 필요하다.
- 스프링 빈의 라이프 사이클에서는 (1) 객체를 생성하고, (2) 의존관계를 주입하는데 이 과정이 끝난 다음에야 필요한 데이터를 사용할 수 있는 준비가 완료된다.
- 따라서 초기화 작업은 의존관계 주입이 끝난 다음에야 이뤄진다.
- 스프링은 의존관계 주입이 완료되면 스프링 빈에게 콜백 메서드를 통해 초기화 시점을 알려주는 다양한 기능을 제공한다.
- 또한, 종료되기 직전에 소멸 콜백을 주어 안전하게 종료 작업을 진행할 수 있도록 돕는다.

### 스프링 빈의 이벤트 라이프사이클
- 스프링 컨테이너 생성 -> 스프링 빈 생성 -> 의존관계 주입 -> 초기화 콜백 -> 사용 -> 소멸전 콜백 -> 스프링 종료
  - 초기화 콜백: 빈이 생성되고, 빈의 의존관계 주입이 완료된 후 호출
  - 소멸전 콜백: 빈이 소멸되기 직전에 호출

### 객체의 생성과 초기화를 분리해야 하는 이유
- 생성자 메서드의 파라미터를 이용하여 값을 바로 초기화하면 편하지 않나?
  - 생성자는 파라미터로 필수정보를 받고 메모리를 할당하여 객체를 '생성'하는 책임을 가지고 있다. 반면에 초기화는 이렇게 생성된 값들을 활용해서 외부 커넥션에 연결하는 등 무거운 동작을 수행한다.
  - 따라서, 생성자 안에서 무거운 초기화 작업을 수행하는 것보다 객체를 생성하는 부분과 초기화하는 부분을 나누는 것이 유지보수 관점에 좋다.
  - 물론 초기화 작업이 내부 값을 변경하는 정도의 단순한 경우라면 생성자에서 한번에 처리하는 것이 더 나은 선택일 수 있다.

---

## 빈 스코프
- 빈이 존재하며 스프링 컨테이너의 관리를 받는 기간, 범위를 의미한다.

### 다양한 빈 스코프 
- 싱글톤
  - 스프링의 기본 스코프로, 스프링 컨테이너의 시작부터 종료까지 유지되어 관리되는 가장 넓은 범위의 스코프이다.
  - 싱글톤 스코프 빈을 요청하면 스프링 컨테이너는 관리하고 있는 싱글톤 빈을 반환한다.
  - 같은 요청이 반복해서 와도 같은 객체 인스턴스의 스프링 빈을 반환한다.
- 프로토타입
  - 빈의 생성과 의존관계 주입까지 관여하고 이후에는 스프링 컨테이너가 관리하지 않는 매우 짧은 범위의 스코프이다.
  - 프로토 타입 빈을 요청하면 요청 시점에 프로토 타입 빈을 생성하고, 필요한 의존관계를 주입한다.
  - 스프링 컨테이너는 생성한 프로토타입 빈을 클라이언트에 반환한다.
  - 깉은 요청이 반복해서 오면 요청마다 새로운 프로토 타입 빈을 생성하여 반환한다.
  - 스프링컨테이너는 프로토타입 빈을 생성하여 의존관계를 주입라고 초기화까지만 관리하기 때문에 이후 빈을 관리할 책임은 프로토타입 빈을 받은 클라이언트에 있다.
    - 따라서 `@PreDestroy`와 같은 종료 메서드가 호출되지 않는다.
    - 종료 메서드에 대한 호출 역시 클라이언트가 해야한다.
- 웹 관련 스코프
  - request: 웹 요청이 들어오고 나갈 때까지 유지되는 스코프이다.
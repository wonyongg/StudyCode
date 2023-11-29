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
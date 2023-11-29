package hello.core;

import hello.core.discount.order.Order;
import hello.core.discount.order.OrderService;
import hello.core.discount.order.OrderServiceImpl;
import hello.core.member.Grade;
import hello.core.member.Member;
import hello.core.member.MemberService;
import hello.core.member.MemberServiceImpl;

public class OrderApp {

    public static void main(String[] args) {
        MemberService memberService = new MemberServiceImpl();
        OrderService orderService = new OrderServiceImpl();

        Long memberId = 1L;
        Member member = new Member(memberId, "황원용", Grade.VIP);
        memberService.join(member);

        Order order = orderService.createOrder(memberId, "루이비통", 10000);

        System.out.println("order = " + order);
        System.out.println("order.calculatePrice() = " + order.calculatePrice());
    }
}

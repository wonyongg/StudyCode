package hello.core.discount.order;

import hello.core.member.Grade;
import hello.core.member.Member;
import hello.core.discount.RateDiscountPolicy;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.*;

class RateDiscountPolicyTest {

    RateDiscountPolicy discountPolicy = new RateDiscountPolicy();

    @Test
    void vip_o() {

        //given
        Member member = new Member(1L, "황원용", Grade.VIP);
        //when
        int discount = discountPolicy.discount(member, 10000);
        //then
        assertThat(discount).isEqualTo(1000);
    }

    @Test
    void vip_x() {

        //given
        Member member = new Member(2L, "느그흥", Grade.BASIC);
        //when
        int discount = discountPolicy.discount(member, 10000);
        //then
        assertThat(discount).isEqualTo(0);
    }

}
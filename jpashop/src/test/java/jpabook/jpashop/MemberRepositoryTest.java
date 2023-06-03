package jpabook.jpashop;


import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringRunner.class)
@SpringBootTest
public class MemberRepositoryTest {

    @Autowired MemberRepository memberRepository;

    @Test
    @Transactional // 엔티티 매니저를 통한 모든 데이터 변경은 항상 트랜잭션 안에서 이루어져야 한다. 없으면 에러가 난다.
    // Transactional 애너테이션이 테스트 케이스에 있으면 테스트가 끝난 후 롤백을 해버린다. 말그대로 테스트이기 때문에 다음 테스트를 위해 롤백시키는 것이다.
    @Rollback(false) //를 쓰면 h2 db에 데이터가 들어갔는지를 확인할 수 있다.
    public void testMember() throws Exception {
        //given
        Member member = new Member();
//        member.setUsername("memberA");

        //when
        Long saveId = memberRepository.save(member);
        Member findMember = memberRepository.find(saveId);

        //then
        Assertions.assertThat(findMember.getId()).isEqualTo(member.getId());
        Assertions.assertThat(findMember.getUsername()).isEqualTo(member.getUsername());
        Assertions.assertThat(findMember).isEqualTo(member);
        /**
         * 같은 트랜잭션 안에서 저장 후 조회하는 것이므로 같은 영속성 컨텍스트 안에서는 id 값이 같으면 같은 엔티티로 인식한다.
         */
        System.out.println("findMember = member : " + (findMember == member));
    }
}
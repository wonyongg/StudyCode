package jpabook.jpashop.domain.service;

import jpabook.jpashop.domain.Member;
import jpabook.jpashop.repository.MemberRepository;
import jpabook.jpashop.service.MemberService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;

import static org.junit.Assert.*;

@RunWith(SpringRunner.class) // JUnit 실행할 때 Spring과 엮어서 실행하겠다.
@SpringBootTest // 스프링부트를 실행한 상태에서 테스트하기 위해 반드시 필요. 없으면 @Autowired 등 전부 실패함
@Transactional // 테스트 케이스에 있으면 테스트 끝나고 전부 Rollback 처리하는 것이 default
public class MemberServiceTest {

    @Autowired
    MemberService memberService;
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    EntityManager em;

    @Test // Settings - Live Templates
//    @Rollback(false)
    public void 회원가입() throws Exception {
        //given
        Member member = new Member();
        member.setName("kim");
        
        //when
        Long savedId = memberService.join(member);

        em.flush();
        /**
         * join 메서드는 repository.save()를 포함한다.
         * 그런데, 회원가입 테스트를 진행하면 insert 쿼리가 나가지 않는다.
         * 회원 가입 -> 회원 정보 저장 단계에서 db로 insert되는 쿼리가 나가야 정상인데 말이다.
         * 여기에는 JPA의 비밀이 숨어있다.
         * Member 객체는 join() -> repository.save() -> em.persist()로 영속성 컨텍스트에 저장된다.
         * 그런데, 영속성 컨텍스트에 저장이 되었다고 해서 곧바로 insert문이 나가는 것은 아니다.(DB마다 다르지만 대부분 그렇다.)
         * 왜냐하면 데이터베이스 트랜잭션이 커밋될 때 flush가 되면서 DB에 insert 쿼리가 나가게 되는데
         * 스프링에서 @Transactional이 테스트 케이스에 있을 때는 기본적으로 Rollback을 하기 때문에 commit이 되지 않기 때문이다.
         * 따라서 DB에 저장되는 insert 쿼리까지 확인하고 싶다면 @Rollback(false)를 테스트 메서드에 붙여야 한다.(그럼 Rollback이 아니라 커밋이 된다.)
         *
         * 하지만 @Rollbak(false)를 하게 되면 실제로 테스트 데이터가 db에 저장되므로 단순히 insert 쿼리만 나가는 것을 확인하고 싶다고 하면
         * em을 @Autowired로 di 주입을 받아 em.flush()로 db에 반영시키면 된다.
         * 앞서 언급했듯이 default가 Rollback이기 때문에 insert 쿼리가 나가고 최종적으로 롤백이 된다.
         */
    
        //then
        assertEquals(member, memberRepository.findOne(savedId));
    }

    @Test(expected = IllegalStateException.class) // 아래 try-catch 문과 같은 효과를 준다. 기대하는 에러를 받고 처리
    public void 중복_회원_예외() throws Exception {
        //given
        Member member1 = new Member();
        member1.setName("kim");
        Member member2 = new Member();
        member2.setName("kim");

        //when
        memberService.join(member1);
        memberService.join(member2); // 예외가 발생해야한다!!
        // validateDuplicateMember에서 던져진 예외가 여기까지 넘어 온다.

//        try {
//            memberService.join(member2);
//        } catch (IllegalStateException e) {
//            return;
//        }

        //then
        fail("예외가 발생해야한다."); // 예외가 발생에서 이 코드까지 오면 안됨. 만약 온다면 테스트 실패.
    }
}
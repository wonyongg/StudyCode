package jpabook.jpashop.domain.repository;

import jpabook.jpashop.domain.Member;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;

import java.util.List;

@Repository// 이 애너테이션이 있으면 컴포넌트 스캔의 대상이 되어 자동으로 스프링 빈으로 등록이 된다.
@RequiredArgsConstructor // em의 EntityManager 주입을 하려면 @PersistenceContext이 필요한데 스프링이 @Autowired도 되게 해주기 때문에 이 애너테이션 사용이 가능하다.
public class MemberRepository {
//    @PersistenceContext // EntityManager를 주입한다.
    private final EntityManager em;

    public void save(Member member) {
        em.persist(member);
    }

    public Member findOne(Long id) {
        return em.find(Member.class, id); // (타입,pk)
    }

    public List<Member> findAll() {

        return em.createQuery("select m from Member  m", Member.class) // query문, 반환타입
                .getResultList(); // List로 반환
    }

    public List<Member> findByName(String name) {
        return em.createQuery("select m from Member m where m.name = :name", Member.class)
                .setParameter("name", name) // 파라미터 name과 :name 바인딩
                .getResultList();
    }
}

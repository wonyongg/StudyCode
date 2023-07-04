package jpabook.jpashop.service;

import jpabook.jpashop.domain.Member;
import jpabook.jpashop.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service // 이 애너테이션이 있으면 컴포넌트 스캔의 대상이 되어 자동으로 스프링 빈으로 등록이 된다.
@Transactional // JPA의 데이터 변경이나 로직들은 가급적이면 트랙잭션 안에서 실행되어야 한다. default로 readOnly = false이며, 쓰기는 true로 하면 안된다.
@RequiredArgsConstructor // final이 있는 필드만을 가지고 생성자를 만들어준다.
public class MemberService {
    private final MemberRepository memberRepository; // 초기값 세팅 후 변경 불가

    // @Autowired 스프링 빈에 등록된 MemberRepository를 주입해준다. 최신 스프링에서는 안 넣어도 됨. (생성자 주입)
//    public MemberService(MemberRepository memberRepository) {
//        this.memberRepository = memberRepository;
//    }
//    @RequiredArgsConstructor 사용으로 주석

    // 회원 가입
    public Long join(Member member) {

        validateDuplicateMember(member); // 중복 회원 검증
        memberRepository.save(member);
        return member.getId();
    }

    private void validateDuplicateMember(Member member) {
        List<Member> findMembers = memberRepository.findByName(member.getName());
        if (!findMembers.isEmpty()) {
            throw new IllegalStateException("이미 존재하는 회원입니다.");
        }

    }


    // 회원 전체 조회
    @Transactional(readOnly = true) // readOnly = true 옵션을 조회하는 메서드에서 사용하면 성능을 최적화한다.
    public List<Member> findMembers() {
        return memberRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Member findOne(Long memberId) {
        return memberRepository.findOne(memberId);
    }
}

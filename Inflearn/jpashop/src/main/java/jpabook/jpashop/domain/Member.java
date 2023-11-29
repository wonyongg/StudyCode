package jpabook.jpashop.domain;



import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter // 실무에서 엔티티에 setter 쓰지 않는다.
public class Member {
    @Id
    @GeneratedValue
    @Column(name = "member_id") // 어디 소속인지 명확하게 표시하는 것이 좋기 때문에 id 보다는 member_id로 쓴다.
    private Long id;

    private String name;

    //@Embeddable, @Embedded 하나만 있어도 무방하나 명시하는 편이 가독성과 코드 파악에 도움이 됨.
    @Embedded
    private Address address;

    /**
     * member에 의해 매핑된 거울일 뿐이며,
     * 여기에 값을 넣는다고 Order 테이블의 외래키 값이 변경되지 않는다.
     */
    @OneToMany(mappedBy = "member") // Order 엔티티의 member 필드에 의해 매핑되었다는 것을 명시
    private List<Order> orders = new ArrayList<>();
}

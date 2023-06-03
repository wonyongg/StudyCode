package jpabook.jpashop.domain;



import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
public class Member {
    @Id
    @GeneratedValue
    @Column(name = "memver_id")
    private Long id;

    private String name;

    //@Embeddable, @Embedded 하나만 있어도 무방하나 명시하는 편이 가독성과 코드 파악에 도움이 됨.
    @Embedded
    private Address address;

    @OneToMany(mappedBy = "member") // Order 엔티티의 member 필드에 의해 매핑되었다는 것을 명시
    private List<Order> orders = new ArrayList<>();
}

package jpabook.jpashop.domain;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
public class Delivery {

    @Id
    @GeneratedValue
    @Column(name = "delivery_id")
    private Long id;

    @OneToOne(mappedBy = "delivery", fetch = FetchType.LAZY)
    private Order order;

    @Embedded //@Embeddable, @Embedded 하나만 있어도 무방하나 명시하는 편이 가독성과 코드 파악에 도움이 됨.
    private Address address;

    /**
     * ORDINAL로 하면 숫자 순서로 들어가기 떄문에 나중에 값이 추가되었을 때 순서가 꼬일 가능성이 있음
     * A 1, B 2였는데 중간에 C가 들어가면 A 1, C 2, B 3이되면서 기존에 B 2로 저장된 값들이 반영이 안되고 그대로라 꼬인다.
     */
    @Enumerated(EnumType.STRING)
    private DeliveryStatus Status; //READY, COMP

}

package jpabook.jpashop.domain;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
@Getter
@Setter
public class Order {

    @Id
    @GeneratedValue
    @Column(name = "order_id") // 그냥 id로 해도 되지만 DBA가 이 방식을 선호함
    private Long id;

    /**
     * 객체는 변경 포인트가 두 군 데(member, orders)인데, 테이블은 외래키 하나이므로
     * 둘 중에 하나를 연관관계 주인으로 잡는 것이다.
     * 즉, Order 엔티티의 member 필드나, Member 엔티티의 orders 필드의 값 중 연관관계의 주인인 필드가 변경될 때
     * 테이블을 변경하는 쿼리가 나가게 된다.
     * 여기서는 외래키가 있는 Order 엔티티의 member를 연관관계의 주인으로 했다.
     * 만약 Member 엔티티의 orders를 연관관계의 주인으로 잡으면
     * Member 엔티티를 바꿨는데 외래키가 있는 Order 엔티티의 업데이트 쿼리가 나가 굉장히 헷갈리게 된다.
     *
     * 여기에 값을 넣으면 Order 테이블의 외래키 값이 변경된다.
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id") // 외래키를 member_id로 설정
    private Member member;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL) // OrderItem 엔티티의 order 필드에 의해 매핑되었다는 것을 명시
    private List<OrderItem> orderItems = new ArrayList<>();

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL) // OneToOne에서 연관관계의 주인은 주로 엑세스하는 곳에 외래키를 둔다.
    @JoinColumn(name = "delivery_id")
    private Delivery delivery;

    private LocalDateTime orderDate;

    /**
     * ORDINAL로 하면 숫자 순서로 들어가기 떄문에 나중에 값이 추가되었을 때 순서가 꼬일 가능성이 있음
     * A 1, B 2였는데 중간에 C가 들어가면 A 1, C 2, B 3이되면서 기존에 B 2로 저장된 값들이 반영이 안되고 그대로라 꼬인다.
     */
    @Enumerated(EnumType.STRING)
    private OrderStatus status; // ORDER, CANCEL

    //==얀관관계 메서드==//
    public void setMember(Member member) {
        this.member = member;
        member.getOrders().add(this);
    }

    public void addOrderItem(OrderItem orderItem) {
        orderItems.add(orderItem);
        orderItem.setOrder(this);
    }

    public void setDelivery(Delivery delivery) {
        this.delivery = delivery;
        delivery.setOrder(this);
    }
}

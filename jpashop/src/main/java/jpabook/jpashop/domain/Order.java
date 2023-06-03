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

    @ManyToOne
    @JoinColumn(name = "member_id") // 외래키가 member_id
    private Member member;

    @OneToMany(mappedBy = "order") // OrderItem 엔티티의 order 필드에 의해 매핑되었다는 것을 명시

    private List<OrderItem> orderItems = new ArrayList<>();

    @OneToOne // OneToOne에서 연관관계의 주인은 주로 엑세스하는 곳에 외래키를 둔다.
    @JoinColumn(name = "delivery_id")
    private Delivery delivery;

    private LocalDateTime orderDate;

    @Enumerated(EnumType.STRING)
    private OrderStatus status; // ORDER, CANCEL
}

package jpabook.jpashop.domain;

import lombok.Getter;

import javax.persistence.Embeddable;

@Embeddable // Address가 내장 타입임을 명시
@Getter // 값타입은 기본적으로 변경이 되어서는 안되기 떄문에 setter를 쓰지 않는다.
public class Address {

    private String city;
    private String street;
    private String zipcode;

    /**
     * jpa 스펙 상 엔티티나 임베디드 타입은 자바 기본 생성자를 만들어야 한다.
     * public 또는 protected로 설정할 수 있기 때문에 protected로 설정했다.
     * public보다 안전한 것 뿐만 아니라
     * protected로 설정된 것을 보고 JPA 스팩상의 이유로 만들었구나 만지지 말자 하고 다른 개발자가 알아차릴 수 있게 도와준다.
     * jpa 구현 라이브러리가 객체를 생성할 때 리플랙션, 프록시 같은 기술을 사용해야하므로 기본 생성자가 필요하다.
     */
    protected Address() {
    }

    /**
     * 값타입에서는 setter를 쓰지 않고 생성자를 써야 한다.
     * 생성할 때만 값이 세팅되고 이후에는 변경 불가하며, 필요한 경우에는 새로운 객체를 만들개 유도하기 위한 것이다.
     */
    public Address(String city, String street, String zipcode) {
        this.city = city;
        this.street = street;
        this.zipcode = zipcode;
    }
}

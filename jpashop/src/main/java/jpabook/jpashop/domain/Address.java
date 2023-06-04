package jpabook.jpashop.domain;

import lombok.Getter;

import javax.persistence.Embeddable;

@Embeddable // Address가 내장 타입임을 명시
@Getter // 값타입은 기본적으로 변경이 되어서는 안되기 떄문에 setter를 쓰지 않는다.
public class Address {

    private String city;
    private String street;
    private String zipcode;

    protected Address() {
        // jpa 스펙 상 엔티티나 임베디드 타입은 자바 기본 생성자를 public 또는 protected로 설정해야 한다. protected가 그나마 더 안전하다.
        // jpa 구현 라이브러리가 객체를 생성할 때 리플랙션 같은 기술을 사용해야하므로 기본 생성자가 필요하다.
    }

    public Address(String city, String street, String zipcode) { // 생성할 때만 값이 세팅되고 이후에는 변경 불가. 새로운 객체를 만들거나 해야 함
        this.city = city;
        this.street = street;
        this.zipcode = zipcode;
    }
}

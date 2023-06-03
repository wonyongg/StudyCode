package jpabook.jpashop.domain;

import lombok.Getter;

import javax.persistence.Embeddable;

@Embeddable // Address가 내장 타입임을 명시
@Getter
public class Address {

    private String city;
    private String street;
    private String zipcode;
}

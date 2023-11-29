package jpabook.jpashop.service;

import jpabook.jpashop.domain.item.Item;
import jpabook.jpashop.repository.ItemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class ItemService {

    private final ItemRepository itemRepository;

    @Transactional
    public void saveItem(Item item) {
        itemRepository.save(item);
    }

    /**
     * 영속성 컨텍스트가 자동 변경
     */
    @Transactional
    public void updateItem(Long itemId, String name, int price, int stockQuantity) {
        Item findItem = itemRepository.findOne(itemId); // db에서 가져옴으로써 영속성 컨텍스트의 관리를 받음
        findItem.setName(name);
        findItem.setPrice(price);
        findItem.setStockQuantity(stockQuantity);
        // 변경사항이 있으므로 트랜잭션이 끝나고 커밋 시 변경을 감지하여(dirty checking) 변경된 부분만 업데이트 쿼리가 나감
    }

    /**
     * 병합(merge) 동작 방식
     * 준영속 엔티티의 식별자 값으로 영속 엔티티를 조회한다.
     * 영속 엔티티의 값을 준영속 엔티티 값으로 병합한다.
     * 이때 값이 없는 필드는 null로 업데이트된다.(병합은 모든 필드를 교체하기 떄문이다.)
     * 트랜잭션 커밋 시 변경 감지가 동작해 데이터베이스에 업테이트 쿼리가 나간다.
     */

    public Item findOne(Long itemId) {
        return itemRepository.findOne(itemId);
    }

    public List<Item> findItems() {
        return itemRepository.findAll();
    }
}

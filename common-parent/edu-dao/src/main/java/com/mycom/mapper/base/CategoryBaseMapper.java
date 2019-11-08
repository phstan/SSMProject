package com.mycom.mapper.base;


import java.util.List;

public interface CategoryBaseMapper<T> {
    public List<T> findAll();
    public T findOne(String cid);

    public void deleteOne(Integer cid);
    public void add(T t);

    public void update(T t);
}

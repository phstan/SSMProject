package com.mycom.model;

import java.util.List;

public class PageBean {
    //当前页面
    private int currentPage ;

    //每页显示条数
    private int currentCount ;

    //总条数
    private int totalCount ;

    //总页面数
    private int totalPage ;

    //limit起始参数
    private int startIndex ;

    //product集合

    private List<Product> productList ;

    public int getCurrentPage() {
        return currentPage;
    }
    /*
     * 控制当前页面的逻辑
     */
    public void setCurrentPage(int currentPage) {

        //判断是否小于第一页
        if(currentPage < 1) {
            this.currentPage = 1;

            //判断是否大于 最大页面数
        }else if(currentPage > getTotalPage()) {
            this.currentPage = getTotalPage();
        }else {
            this.currentPage = currentPage;
        }

    }

    public int getCurrentCount() {
        return currentCount;
    }

    //每页显示条数
    public void setCurrentCount(int currentCount) {
        this.currentCount = currentCount;
    }

    public int getTotalCount() {
        return totalCount;
    }

    // 总条数
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public int getTotalPage() {
        return totalPage;
    }

    /*
     * 设置总页面数
     *  总条数 ：20 ， 每页显示12条 -->2页
     */
    public void setTotalPage() {
        this.totalPage = (int) Math.ceil( 1.0 * getTotalCount() / getCurrentCount() );
    }

    public int getStartIndex() {
        return startIndex;
    }

    public void setStartIndex() {
        this.startIndex =( getCurrentPage() - 1 ) * getCurrentCount() ;
    }

    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }
}

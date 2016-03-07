/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.model

/**
 * Created by Irene on 2015/9/2.
 */
enum DisplayStatus {

    PENDING_PAYMENT("pending-payment", "待付款", true, true, true, false, true, false, 0),
    PENDING_CONFIRM_DELIVER_TIME("pending-conf-deliver-time", "待选择收货时间", true, false, false, false, true, false, 5),
    PENDING_DELIVERY("pending-delivery", "待发货", false, false, false, false, true, false, 10),
    DELIVERY_PROCESSING("delivering", "发货中", true, false, false, false, false, true, 20),
    PENDING_RETRIEVAL("pending-retrieval", "待取货", true, false, false, false, false, false, 30),
    ALREADY_RETRIEVAL("already-retrieval", "已取货", true, false, false, false, false, false, 35),
    DELIVERED("pending-comment", "待评价", true, false, false, true, false, false, 40),
    PENDING_REFUND("pending-refund", "待退款", false, false, false, false, false, false, 50),
    CANCELLED("cancelled", "已退款", false, false, false, false, false, false, 60),
    COMMENTED("cancelled", "已评价", false, false, false, false, false, false, 70),
    UNEXPECTED("error", "异常状态", false, false, false, false, false, false, 99);

    public String name;
    public String description;
    public int weight;
    public boolean visible; //在h5订单列表显示filter
    public boolean refundable;
    public boolean payable;
    public boolean commentable;
    public boolean deliverTimeEditable
    public boolean deliveryConfirmable

    def static statusMapping = [
            [PaymentStatus.UNPAID, DeliveryStatus.INSTORE]                             : PENDING_PAYMENT,
            [PaymentStatus.UNPAID, DeliveryStatus.CONFIRM_DELIVER_DATE]: PENDING_PAYMENT,
            [PaymentStatus.PAID_FOR_DEPOSIT, DeliveryStatus.INSTORE]                   : PENDING_PAYMENT,
            [PaymentStatus.PAID_FOR_DEPOSIT, DeliveryStatus.CONFIRM_DELIVER_DATE]: PENDING_PAYMENT,
            [PaymentStatus.PAID_FOR_FULLPRICE, DeliveryStatus.INSTORE]                 : PENDING_CONFIRM_DELIVER_TIME,
            [PaymentStatus.PAID_FOR_FULLPRICE, DeliveryStatus.CONFIRM_DELIVER_DATE]    : PENDING_DELIVERY,
            [PaymentStatus.PAID_FOR_FULLPRICE, DeliveryStatus.PROCESSING]              : DELIVERY_PROCESSING,
            [PaymentStatus.PAID_FOR_FULLPRICE, DeliveryStatus.DELIVERING]              : DELIVERY_PROCESSING,
            [PaymentStatus.PAID_FOR_FULLPRICE, DeliveryStatus.ARRIVED_AT_ORGANIZER]    : PENDING_RETRIEVAL,
            [PaymentStatus.PAID_FOR_FULLPRICE, DeliveryStatus.CUSTOMER_GOT_THE_PRODUCT]: ALREADY_RETRIEVAL,
            [PaymentStatus.PAID_FOR_FULLPRICE, DeliveryStatus.DELIVERED]               : DELIVERED,
            [PaymentStatus.PAID_FOR_FULLPRICE, DeliveryStatus.COMMENTED]               : COMMENTED,
            [PaymentStatus.PENDING_REFUND, DeliveryStatus.INSTORE]                     : PENDING_REFUND,
            [PaymentStatus.PENDING_REFUND, DeliveryStatus.DELIVERED]                   : PENDING_REFUND,
            [PaymentStatus.UNPAID_CANCELLED, DeliveryStatus.INSTORE]                   : CANCELLED,
            [PaymentStatus.REFUND_DEPOSIT, DeliveryStatus.INSTORE]                     : CANCELLED,
            [PaymentStatus.REFUND_FULLPRICE, DeliveryStatus.INSTORE]                   : CANCELLED,
            [PaymentStatus.UNPAID_CANCELLED, DeliveryStatus.DELIVERED]                 : CANCELLED,
            [PaymentStatus.REFUND_DEPOSIT, DeliveryStatus.DELIVERED]                   : CANCELLED
    ]

    DisplayStatus(String name,
                  String description,
                  boolean visible,
                  boolean refundable,
                  boolean payable,
                  boolean commentable,
                  boolean deliverTimeEditable,
                  boolean deliveryConfirmable,
                  int weight) {
        this.name = name;
        this.description = description;
        this.visible = visible;
        this.refundable = refundable;
        this.payable = payable;
        this.commentable = commentable;
        this.deliverTimeEditable = deliverTimeEditable;
        this.deliveryConfirmable = deliveryConfirmable;
        this.weight = weight;
    }

    public static DisplayStatus valueOf(int paymentStatus, int deliveryStatus) {
        DisplayStatus thisValue = statusMapping.get([PaymentStatus.valueOf(paymentStatus), DeliveryStatus.valueOf(deliveryStatus)])
        if(!thisValue) thisValue = UNEXPECTED
        return thisValue
    }

    public static DisplayStatus findByName(String name) {
        DisplayStatus.values().find { it.name == name }
    }
}

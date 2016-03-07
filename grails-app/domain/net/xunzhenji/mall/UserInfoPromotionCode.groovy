/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import org.apache.commons.lang.builder.HashCodeBuilder

/**
 * Created by Irene on 2015/11/30.
 */
class UserInfoPromotionCode implements Serializable {
    def UserInfo userInfo
    def PromotionCode promotionCode

    boolean equals(other) {
        if (!(other instanceof UserInfoPromotionCode)) {
            return false
        }

        other.userInfo?.id == userInfo?.id &&
                other.promotionCode?.id == promotionCode?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (userInfo) builder.append(userInfo.id)
        if (promotionCode) builder.append(promotionCode.id)
        builder.toHashCode()
    }
}

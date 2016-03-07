/*
 * Copyright (c) 2015 广州市源穑农业科技发展有限公司 版权所有
 * GUANGZHOU YUANSE AGRICULTURE TECHNOLOGY CO.,LTD. All Rights Reserved.
 */

package net.xunzhenji.mall

import org.apache.commons.lang.builder.HashCodeBuilder

class LxGroupMembers implements Serializable {
    UserInfo userInfo
    LxGroup lxGroup

    static mapping = {
        id composite: ['userInfo', 'lxGroup']
        version false
    }

    boolean equals(other) {
        if (!(other instanceof LxGroupMembers)) {
            return false
        }

        other.userInfo?.id == userInfo?.id &&
                other.lxGroup?.id == lxGroup?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (userInfo) builder.append(userInfo.id)
        if (lxGroup) builder.append(lxGroup.id)
        builder.toHashCode()
    }
}

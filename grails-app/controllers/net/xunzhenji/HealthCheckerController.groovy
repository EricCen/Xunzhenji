package net.xunzhenji

import net.xunzhenji.util.ErrorCodeUtil

class HealthCheckerController {

    def index() {
        render ErrorCodeUtil.noError()
    }
}

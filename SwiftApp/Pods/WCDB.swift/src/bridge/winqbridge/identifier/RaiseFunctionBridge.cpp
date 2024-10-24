//
// Created by qiuwenchen on 2022/5/30.
//

/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "RaiseFunctionBridge.h"
#include "ObjectBridge.hpp"
#include "RaiseFunction.hpp"

CPPRaiseFunction WCDBRaiseFunctionCreate()
{
    return WCDBCreateCPPBridgedObject(CPPRaiseFunction, WCDB::RaiseFunction);
}
void WCDBRaiseFunctionSetAction(CPPRaiseFunction function,
                                enum WCDBSyntaxRaiseAction action,
                                const char* _Nullable errMsg)
{
    WCDBGetObjectOrReturn(function, WCDB::RaiseFunction, cppFunction);
    cppFunction->syntax().errorMessage = errMsg;
    switch (action) {
    case WCDBSyntaxRaiseAction_Ignore:
        cppFunction->syntax().switcher = WCDB::Syntax::RaiseFunction::Switch::Ignore;
        break;
    case WCDBSyntaxRaiseAction_Rollback:
        cppFunction->syntax().switcher = WCDB::Syntax::RaiseFunction::Switch::Rollback;
        break;
    case WCDBSyntaxRaiseAction_Abort:
        cppFunction->syntax().switcher = WCDB::Syntax::RaiseFunction::Switch::Abort;
        break;
    case WCDBSyntaxRaiseAction_Fail:
        cppFunction->syntax().switcher = WCDB::Syntax::RaiseFunction::Switch::Fail;
        break;
    }
}
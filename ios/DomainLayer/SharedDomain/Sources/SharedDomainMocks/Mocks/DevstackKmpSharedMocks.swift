//
//  Created by David Kadlček on 14.04.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation
import DevstackKmpShared
import SharedDomain

public final class GetBooksUseCaseMock: UseCaseFlowNoParamsMock<[Book]>, GetBooksUseCase {}
public final class RefreshBooksUseCaseMock: UseCaseResultMock, RefreshBooksUseCase {}

//
//  ConvexClient.swift
//  brewnote
//
//  Created by JD Penuliar on 3/17/26.
//

import ConvexMobile
import ClerkConvex

@MainActor
let convexClient = ConvexClientWithAuth(
    deploymentUrl: Env.convexDeploymentUrl,
    authProvider: ClerkConvexAuthProvider()
)

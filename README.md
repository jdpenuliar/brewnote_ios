# brewnote_ios
iOS version of brewnote calling convex

# claude prompt and system design

---
  Prompt to use

  Build a native iOS app called "Brew Note" in Swift using SwiftUI. This app is the mobile
  companion to an existing web app built with Convex, Next.js, and Clerk auth.

  ## Backend (already exists — do NOT change it)
  - Convex deployment: https://energetic-bass-561.convex.cloud
  - Auth: Clerk (frontend API: https://worthy-kiwi-64.clerk.accounts.dev)
  - All Convex functions require a valid Clerk JWT passed as a Bearer token

  ## Data Models (mirror the Convex schema)

  ### Beans
  - name: String
  - species: [String] — enum: ARABICA, ROBUSTA, LIBERICA, EXCELSA
  - countryOfOrigin: String
  - openFoodFactsId: String? (barcode ID)
  - createdById: String (Clerk user ID)
  - createdAt: Int (timestamp)

  ### BrewNotes
  - brewMethod: String (Espresso, V60, Aeropress, Chemex, French Press, Moka Pot, Cold Brew, or custom)
  - grind: String? — enum: EXTRA_COARSE, COARSE, MEDIUM_COARSE, MEDIUM, MEDIUM_FINE, FINE, EXTRA_FINE
  - roast: String? — enum: LIGHT, MEDIUM_LIGHT, MEDIUM, MEDIUM_DARK, DARK
  - beansWeight: Double?
  - beansWeightType: String? — GRAMS or OUNCES
  - brewTime: Int? (seconds)
  - brewTemperature: Double?
  - brewTemperatureType: String? — CELSIUS or FAHRENHEIT
  - waterToGrindRatio: String? (e.g. "15:1")
  - rating: Double? (0–5)
  - notes: String?
  - beans: [Bean] (linked via brewNotesBeans junction table, returned pre-populated in queries)

  ## Convex HTTP API (call these as JSON POST/GET via Convex's HTTP API)
  All calls go to https://energetic-bass-561.convex.cloud/api/query or /api/mutation
  with header: Authorization: Bearer <clerk_jwt>

  Queries (POST to /api/query):
  - {"path": "brews:getRecentBrews", "args": {"paginationOpts": {"numItems": 20, "cursor": null}}}
  - {"path": "brews:getBrewById", "args": {"id": "<brewNoteId>"}}
  - {"path": "brews:getBrews", "args": {"paginationOpts": ..., "filters": {optional brewMethod, grind, roast, rating, createdById}}}
  - {"path": "beans:getRecentBeans", "args": {"paginationOpts": {"numItems": 20, "cursor": null}}}
  - {"path": "beans:getBeanById", "args": {"id": "<beanId>"}}
  - {"path": "beans:getBeans", "args": {"paginationOpts": ..., "filters": {optional name, countryOfOrigin, species, createdById}}}
  - {"path": "beans:checkBeanExists", "args": {"openFoodFactsId": "<id>"}}
  - {"path": "home:getHomeStats", "args": {}}

  Mutations (POST to /api/mutation):
  - {"path": "brews:upsertBrews", "args": {"brewNote": {...}, "beanIds": ["<id>",...]}}
  - {"path": "beans:upsertBeans", "args": {"bean": {...}}}

  ## App Structure

  ### Screens
  1. **Sign In** — Clerk auth via WebAuthenticationSession (OAuth/email)
  2. **Home Tab**
     - Stats card: brews this week + top brew method (from getHomeStats)
     - Recent Brews list (last 5, showing bean name, method, star rating)
     - Recent Beans list (last 5, showing name, country)
     - FAB (+) that expands to "Add Brew" and "Add Bean"
  3. **Brews Tab**
     - Paginated list of all brews with infinite scroll
     - Tap → Brew Detail (method, beans, all parameters formatted nicely, e.g. brew time as "3m 45s")
     - Edit button on detail screen
  4. **Beans Tab**
     - Paginated list of all beans
     - Tap → Bean Detail (name, species, origin, associated brews)
     - Barcode scanner using AVFoundation → looks up OpenFoodFacts API
       (GET https://world.openfoodfacts.org/api/v0/product/<barcode>.json)
     - Edit button on detail screen
  5. **Profile Tab**
     - Show Clerk user info (name, email, avatar)
     - Sign out button

  ### Add/Edit Brew Form
  - Brew method: segmented/picker (presets + "Custom" text input)
  - Bean picker: multi-select searchable list from existing beans
  - Rating: 1–5 star selector
  - Grind size: pill button row (7 options)
  - Roast level: pill button row (5 options)
  - Dose: number field + GRAMS/OUNCES toggle
  - Temperature: number field + CELSIUS/FAHRENHEIT toggle
  - Brew time: MM:SS picker or number field in seconds
  - Water:grind ratio: text field (e.g. "15:1")
  - Notes: multiline text field

  ### Add/Edit Bean Form
  - Name: text field
  - Country of origin: searchable picker (standard country list)
  - Species: multi-select pill buttons (ARABICA, ROBUSTA, LIBERICA, EXCELSA)
  - Barcode scanner button (auto-fills name from OpenFoodFacts)
  - Duplicate prevention: warn if openFoodFactsId already exists (use checkBeanExists)

  ## Technical Requirements
  - Swift 5.9+, SwiftUI, iOS 17+
  - Clerk auth: use ClerkSDK (https://clerk.com/docs/references/ios/overview) or implement
    OAuth flow manually using ASWebAuthenticationSession if SDK is unavailable
  - Networking: URLSession with async/await, no third-party HTTP libraries
  - State management: @Observable / @StateObject, no third-party state libs
  - Pagination: implement cursor-based pagination matching Convex's paginationOpts format
  - Dark mode support
  - No third-party dependencies beyond ClerkSDK (if used)

  ## Style
  - Design language similar to Oura Ring / Untapped apps: dark-first, minimal, card-based
  - Accent color: coffee brown (#6F4E37) or amber
  - SF Symbols for icons
  - Rounded cards for brew/bean items

  ---
  Tips before you start:
  - Check if Clerk has an official iOS SDK first — if not, you'll implement the auth flow via ASWebAuthenticationSession and manage the JWT manually
  - The Convex HTTP API path format (brews:getRecentBrews) is what matters — confirm this matches exactly with your Convex deployment by testing one call with curl first
  - The beanNotes table exists in the schema but isn't wired up in the frontend yet, so skip it for v1


# Folder structure
brewnote/
  brewnoteApp.swift          -- Clerk SDK init + environment setup
  ContentView.swift          -- Auth state router (loading/sign-in/main app)
  Env.swift                  -- Config constants (Clerk key, Convex URL)
  brewnote.entitlements      -- Associated domains for Clerk
  App/
    ConvexClient.swift       -- Global ConvexClientWithAuth instance
  Models/
    Bean.swift, BrewNote.swift, Enums.swift
  Features/
    Auth/Views/SignInView.swift     -- Login screen with Clerk AuthView
    Home/Views/HomeView.swift       -- Placeholder
    Brews/Views/                    -- Placeholders (List, Detail, Form)
    Beans/Views/                    -- Placeholders (List, Detail, Form)
    Profile/Views/ProfileView.swift -- Placeholder
  Navigation/
    MainTabView.swift        -- Tab bar (Home, Brews, Beans, Profile)
  Shared/
    Theme/AppTheme.swift     -- Coffee brown color constant
    Components/              -- Empty (for reusable UI)
    Extensions/              -- Empty (for Swift extensions)

# French Administrative Platform Technical Analysis

Technical analysis of major French government platforms for automation compatibility, API availability, and authentication requirements.

---

## 🔐 FRANCECONNECT - Identity Federation System

### Overview
FranceConnect is France's national identity federation system that allows citizens to use existing credentials from one service (Impots.gouv, Ameli, La Poste Identity) to authenticate to other government services.

### Technical Architecture
- **Type:** OpenID Connect (OIDC) based federation
- **Identity Providers (IdP):**
  - Impots.gouv.fr (DGFiP)
  - Ameli.fr (Assurance Maladie)
  - L'Identité Numérique La Poste
  - MSA (agricultural social security)
  - France Identité (national digital identity app)
  - MobileConnect et moi
  - YRIS
  - TrustMe

### For Service Providers
- **Integration:** Required for most government services
- **API Documentation:** https://partenaires.franceconnect.gouv.fr/
- **Access:** Restricted to:
  - Public administrations
  - Local authorities
  - Private companies with public service missions
- **Process:**
  1. Request access via franceconnect.gouv.fr
  2. Provide legal documentation
  3. Technical integration (OAuth 2.0 / OpenID Connect)
  4. Testing in sandbox environment
  5. Production approval

### API Capabilities
- **Identity verification:** Name, first name, birth date/place
- **Data retrieval:** Via "API FranceConnectées" (see below)
- **No automation for end users:** FranceConnect is for service providers, not for automating user actions

### Automation Feasibility
- ❌ **Cannot be automated for form-filling:** FranceConnect requires real user authentication
- ✅ **Can be integrated:** If building a registered service
- ⚠️ **User must authenticate:** Each session requires actual user login

---

## 💰 IMPOTS.GOUV.FR - Tax Administration

### Platform Details
- **URL:** https://www.impots.gouv.fr/
- **Authority:** DGFiP (Direction Générale des Finances Publiques)
- **Mobile App:** Yes (iOS, Android)

### Authentication
- **FranceConnect:** ✅ Required for most services
- **Direct login:** Username/password (fiscal number + password)
- **2FA:** Increasingly required for sensitive operations

### API Availability

#### For Individuals - NO PUBLIC API
- ❌ **No public API** for individuals to automate their own tax filing
- ❌ **No official scraping allowed** (Terms of Service prohibit automation)
- ⚠️ **Anti-bot measures:** CAPTCHA, rate limiting, session fingerprinting

#### For Service Providers - LIMITED APIs

**1. API Impôt Particulier** (via API Particulier)
- **Purpose:** Retrieve tax data WITH user consent
- **Access:** Authorized administrations and services only
- **URL:** https://api.gouv.fr/les-api/impot-particulier
- **FranceConnect:** Required (user must authenticate)
- **Data provided:**
  - Tax notice (avis d'imposition)
  - Tax household income (revenu fiscal de référence)
  - Tax amount
  - Number of dependents
- **Use case:** Third parties verifying user income for loans, benefits, etc.
- **NOT for:** Automated form filling by users themselves

**2. API Particulier**
- **URL:** https://particulier.api.gouv.fr/
- **Purpose:** Aggregate API for multiple government data sources
- **Includes:** Tax data, CAF data, Pôle Emploi data
- **Access:** Authorized organizations only (must apply)
- **User consent:** Required via FranceConnect
- **Rate limits:** Yes
- **Cost:** Free for eligible public services

### Form Submission
- **Online filing:** Mandatory if internet access available
- **Platform:** Web-based form on impots.gouv.fr
- **Prefilled data:** Tax returns increasingly prefilled
- **Automation:**
  - ❌ Direct automation: Prohibited
  - ❌ Scraping: Against ToS and technically prevented
  - ⚠️ Manual only: User must log in and submit

### Technical Barriers
- CAPTCHA on login and sensitive operations
- Session tokens with short expiration
- Browser fingerprinting
- IP-based rate limiting
- Terms of Service prohibit automated access

### Automation Verdict
- ❌ **User automation:** NOT POSSIBLE (and illegal)
- ✅ **Service provider integration:** Possible with authorization
- ⚠️ **Recommended approach:** Assist user with data collection, user submits manually

---

## 🏥 AMELI.FR - Health Insurance (CPAM)

### Platform Details
- **URL:** https://www.ameli.fr/
- **Authority:** CNAM (Caisse Nationale d'Assurance Maladie)
- **Mobile App:** Yes (iOS, Android) - "Ameli"

### Authentication
- **FranceConnect:** ✅ Supported
- **Direct login:** Social security number + password
- **2FA:** Available (recommended)

### API Availability

#### For Service Providers - YES (Limited)

**1. API Droits à l'Assurance Maladie**
- **URL:** https://api.gouv.fr/les-api/api_ameli_droits_cnam
- **Purpose:** Verify health insurance coverage
- **FranceConnect:** Required
- **Data provided:**
  - Coverage status (yes/no)
  - Start/end dates of coverage
  - Regime type
  - Beneficiaries in household
- **Access:** Authorized organizations only
- **Use case:** Verify patient coverage before care

**2. API Indemnités Journalières**
- **URL:** https://api.gouv.fr/les-api/api-indemnites-journalieres-cnam
- **Purpose:** Retrieve daily sickness benefit amounts
- **FranceConnect:** Required
- **Access:** Restricted to authorized services

**3. API Complémentaire Santé Solidaire (C2S)**
- **Purpose:** Check C2S eligibility
- **Via:** API Particulier
- **Access:** Authorized services only

### For Individual Users - NO API
- ❌ No public API for personal use
- ❌ Automation prohibited in Terms of Service

### Common Operations
- View reimbursements (décomptes)
- Download attestations (coverage certificates)
- Update personal information
- Order European Health Insurance Card (CEAM)

### Technical Barriers
- Login CAPTCHA
- Session management
- Anti-scraping measures
- Terms of Service against automation

### Automation Verdict
- ❌ **User automation:** NOT POSSIBLE
- ✅ **Service provider data retrieval:** Possible with authorization
- ⚠️ **Recommended:** Manual access only

---

## 👶 CAF.FR - Family Allowance Fund

### Platform Details
- **URL:** https://www.caf.fr/
- **Mobile App:** Yes (iOS, Android) - "Caf - Mon Compte"
- **Geographic:** Network of local CAF offices (departmental)

### Authentication
- **FranceConnect:** ✅ Supported
- **Direct login:** Allocataire number + password
- **Login varies:** By département (local CAF sites)

### API Availability

#### For Service Providers - PLANNED

**1. API Quotient Familial** (In development)
- **Status:** Specification phase (as of 2024-2026)
- **Purpose:** Retrieve family quotient (QF)
- **FranceConnect:** Will be required
- **Data planned:**
  - Family quotient (QF)
  - Household composition
  - Benefit eligibility
- **Access:** Authorized organizations (municipalities, schools, etc.)
- **Use case:** Determine tariffs for daycare, school meals, activities

**2. Via API Particulier**
- **Current availability:** Limited CAF data via API Particulier
- **URL:** https://particulier.api.gouv.fr/
- **Data available:**
  - Family composition (limited)
  - Housing benefit status
  - RSA recipient status
- **Access:** Authorized organizations only

### For Individual Users - NO API
- ❌ No public API for personal automation
- ❌ Terms of Service prohibit scraping

### Common Operations
- Apply for benefits (online forms)
- Quarterly income declarations (RSA, Prime d'activité)
- Upload supporting documents
- Download attestations (benefit statements)
- Update family situation

### Technical Challenges
- Decentralized: Each département has separate portal
- Different URLs: cafXX.fr (where XX = département number)
- CAPTCHA on login
- Document upload required (scans)
- Complex multi-step forms

### Automation Verdict
- ❌ **User automation:** NOT POSSIBLE
- ⚠️ **Future API:** May become available for authorized services
- 📝 **Current state:** Manual only, document-heavy

---

## 🏢 AUTOENTREPRENEUR.URSSAF.FR - Self-Employed

### Platform Details
- **URL:** https://www.autoentrepreneur.urssaf.fr/
- **Authority:** URSSAF (Union de Recouvrement des Cotisations de Sécurité Sociale et d'Allocations Familiales)
- **Mobile App:** Yes - "AutoEntrepreneur Urssaf"

### Authentication
- **FranceConnect:** ✅ Supported
- **Direct login:** SIRET + password

### API Availability

#### For Individual Auto-Entrepreneurs - NO PUBLIC API
- ❌ No public API for declaring revenue
- ❌ Automation prohibited

#### For Software Providers - YES (Certified Software)

**"Logiciel de Tenue de Caisse"**
- **Requirement:** Since 2018, certain businesses need certified accounting software
- **Certification:** LNE (Laboratoire National de Métrologie et d'Essais)
- **Purpose:** Anti-fraud measure for cash-based businesses
- **Integration:** Certified software can interface with URSSAF systems
- **Access:** Software vendors must be certified

**Partner Software:**
- Several commercial partners integrate with URSSAF
- Examples: Indy, Shine, Freebe, Tiime, Pennylane
- Integration allows semi-automated declarations
- Still requires user review and approval

### Common Operations
- Monthly/quarterly revenue declaration
- Social contribution payment
- View contribution history
- Download attestations (URSSAF compliance certificates)
- Update business information

### Technical Details
- Simple interface (compared to other platforms)
- Revenue declaration is straightforward (3 fields typically)
- Declarations must be submitted even if revenue = 0
- Late declarations incur penalties automatically

### Automation Verdict
- ❌ **Direct user automation:** NOT ALLOWED
- ⚠️ **Via certified software:** Possible if using partner platforms
- 📊 **Data export:** Users can export payment history
- 🔌 **Recommendation:** Integrate with partner accounting software

---

## 🏛️ SERVICE-PUBLIC.FR - Unified Portal

### Platform Details
- **URL:** https://www.service-public.fr/
- **Purpose:** Information portal + procedural aggregator
- **Authority:** DILA (Direction de l'Information Légale et Administrative)

### Functionality
- ✅ Information resource (not a transactional platform)
- ✅ Links to actual service portals
- ✅ Form downloads
- ✅ Procedural guidance

### API - NONE
- No APIs (it's a documentation/portal site)
- Links redirect to actual platforms (ANTS, Impots, CAF, etc.)

### Automation
- N/A - Not a transactional platform

---

## 🪪 ANTS.GOUV.FR - National Agency for Secure Documents

### Platform Details
- **URL:** https://ants.gouv.fr/
- **Services:**
  - Driver's license
  - Vehicle registration (carte grise)
  - Passport
  - National ID card

### Authentication
- **FranceConnect:** ✅ Required for most services
- **No direct login:** Must use FranceConnect

### API Availability
- ❌ **No public API**
- ❌ **No automation allowed**

### Process
- Pre-application online
- Upload documents (photos, scans)
- Appointment scheduling (for ID documents)
- In-person validation (biometrics for passports/ID)

### Technical Barriers
- Document upload required (photos, scans)
- CAPTCHA
- Appointment booking (physical presence needed)
- Biometric data collection in person

### Automation Verdict
- ❌ **Not automatable** (requires physical presence + biometrics)
- 📤 **Can assist:** Prepare documents, fill forms, schedule appointment
- 👤 **User must:** Appear in person for ID documents

---

## 📊 SUMMARY MATRIX

| Platform | Public API | Service Provider API | FranceConnect Required | Automation Feasible | Manual Only Operations |
|----------|-----------|---------------------|----------------------|-------------------|----------------------|
| **Impots.gouv.fr** | ❌ No | ✅ Yes (read-only, with consent) | ✅ Yes | ❌ No | Tax filing, payments |
| **Ameli.fr** | ❌ No | ✅ Yes (limited, read-only) | ✅ Yes | ❌ No | All operations |
| **CAF.fr** | ❌ No | ⚠️ In development | ✅ Yes | ❌ No | Applications, declarations |
| **AutoEntrepreneur.URSSAF** | ❌ No | ⚠️ Via certified software | ✅ Yes | ⚠️ Limited (via partners) | Revenue declarations |
| **ANTS.gouv.fr** | ❌ No | ❌ No | ✅ Yes | ❌ No | All (requires in-person) |
| **Service-Public.fr** | ❌ N/A | ❌ N/A | ❌ N/A | ❌ N/A | Information only |

---

## 🤖 AUTOMATION STRATEGIES & RECOMMENDATIONS

### ❌ What CANNOT Be Automated (Legally & Technically)

1. **Tax filing for individuals** (Impots.gouv.fr)
   - Prohibited by Terms of Service
   - Technical anti-bot measures
   - Legal liability for errors

2. **Health insurance claims** (Ameli.fr)
   - No API for individual use
   - Anti-scraping protections

3. **CAF benefit applications**
   - Complex, document-heavy processes
   - No automation APIs
   - Fraud prevention measures

4. **Identity documents** (ANTS)
   - Requires physical presence
   - Biometric data collection

### ⚠️ What CAN Be Semi-Automated

1. **Data aggregation** (read-only)
   - IF building an authorized service
   - Via API Particulier + FranceConnect
   - Requires:
     - Legal entity (company/association)
     - Public service mission justification
     - User consent for each data access
     - Habilitation (authorization) from data providers

2. **Form assistance** (preparation only)
   - Gather user information
   - Prefill form fields (on user's device)
   - Guide user through process
   - User completes final submission manually

3. **Document management**
   - Organize supporting documents
   - Generate PDFs for upload
   - Reminder system for deadlines

4. **URSSAF via partners**
   - Use certified accounting software (Indy, Shine, etc.)
   - Semi-automated revenue declaration
   - User must review and approve

### ✅ Recommended Approach for AI Form-Filling Service

#### Tier 1: Information Assistant (LEGAL, LOW-RISK)
- **What it does:**
  - Explains obligations and deadlines
  - Lists required documents
  - Provides procedural guidance
  - Sends reminders
- **Tech:** Chatbot, knowledge base, calendar integration
- **Risk:** None
- **Value:** High for user education

#### Tier 2: Document Preparation Assistant (LEGAL, MODERATE RISK)
- **What it does:**
  - Collects information via conversation
  - Generates prefilled PDF forms (locally)
  - Organizes documents for upload
  - Provides step-by-step instructions
- **Tech:** PDF generation, local storage, structured data collection
- **Risk:** Low (user reviews everything)
- **Value:** Saves time, reduces errors
- **Critical:** User retains full control and final submission

#### Tier 3: Integration Partner (LEGAL, REQUIRES AUTHORIZATION)
- **What it does:**
  - Retrieves user data via APIs (with consent)
  - Autofills forms with verified data
  - Connects to certified accounting software (URSSAF)
  - Provides dashboard of obligations
- **Tech:** API Particulier integration, FranceConnect, partner APIs
- **Requirements:**
  - Legal entity with public service mission or partnership
  - Habilitation from DINUM, DGFiP, CNAM, CNAF
  - Data protection compliance (GDPR, CNIL)
  - Secure infrastructure
- **Risk:** Moderate (regulatory compliance burden)
- **Value:** High automation, official data sources

#### ❌ Tier 4: Automated Submission (ILLEGAL - DO NOT PURSUE)
- **What it would do:** Submit forms on behalf of users without their direct action
- **Why not:**
  - Violates Terms of Service of all platforms
  - Illegal impersonation
  - Criminal liability for errors
  - Technical barriers (CAPTCHA, 2FA, anti-bot)
  - Impossible to maintain (platforms change frequently)

---

## 🔐 FRANCECONNECT INTEGRATION GUIDE (For Authorized Services)

If building an authorized service:

### 1. Eligibility Check
Are you:
- A public administration?
- A local government entity?
- A private company with a public service mission (DSP)?

If NO → Cannot integrate FranceConnect or APIs

### 2. Application Process
1. **Request access:** https://franceconnect.gouv.fr/partenaires
2. **Submit documents:**
   - Legal status proof
   - Service description
   - Data protection impact assessment (AIPD)
   - CNIL compliance documentation
3. **Technical onboarding:**
   - OAuth 2.0 / OpenID Connect integration
   - Sandbox testing
   - Security audit
4. **Production approval**

### 3. API Habilitation (Separate Process)
Each API requires separate authorization:
- **API Impôt Particulier:** Apply via api.gouv.fr
- **API Particulier:** Apply via particulier.api.gouv.fr
- **API Ameli:** Apply via CNAM
- **API CAF:** Apply via CNAF

**Timeline:** 3-6 months for full authorization

---

## 📝 LEGAL & COMPLIANCE CONSIDERATIONS

### GDPR & Data Protection
- **User consent:** Explicit opt-in required for data processing
- **Purpose limitation:** Data used only for stated purpose
- **Data minimization:** Collect only necessary fields
- **Right to erasure:** Users can request data deletion
- **CNIL registration:** May be required depending on processing

### Terms of Service
- **Impots.gouv.fr:** Prohibits automated access (Article 7.2)
- **Ameli.fr:** Prohibits scraping and unauthorized data collection
- **CAF.fr:** Restricts automated form submission
- **URSSAF:** Allows access via certified software only

### Criminal Liability
- **Fraudulent access:** 2 years imprisonment, €60,000 fine (Article 323-1 Code Pénal)
- **Identity fraud:** 1 year, €15,000 fine
- **Tax fraud:** Up to 5 years, €500,000 fine

### Recommendations
- ✅ **Comply fully** with Terms of Service
- ✅ **Obtain authorizations** before API integration
- ✅ **User-driven:** User must explicitly approve all submissions
- ✅ **Transparency:** Clearly explain what the service does and doesn't do
- ❌ **Never:** Submit forms without explicit user action

---

## 🎯 CONCLUSION & VIABLE PRODUCT STRATEGY

### What Users Need (Pain Points)
1. Understanding complex obligations
2. Tracking deadlines
3. Gathering required documents
4. Filling repetitive information across multiple forms
5. Avoiding errors and penalties

### What Technology Can Provide Legally
1. **Education:** Explain obligations in plain language
2. **Organization:** Calendar, reminders, document storage
3. **Efficiency:** Prefill forms with user-provided data (stored locally)
4. **Guidance:** Step-by-step instructions with screenshots
5. **Peace of mind:** Validation checks before user submits

### Viable Product: "AI Administrative Assistant"

**Core Features (No authorization needed):**
- Obligation calendar with smart reminders
- Document checklist generator
- Conversational form assistant (ask questions, AI helps fill locally)
- PDF generator for common forms (prefilled from user input)
- Deadline tracker synced with official calendars
- Multi-platform guide (how to submit on each portal)

**Premium Features (Requires authorization as service provider):**
- FranceConnect integration for identity verification
- API-based data retrieval (tax notice, CAF quotient)
- Direct document upload to compatible platforms
- Partner integration (certified URSSAF software)

**Value Proposition:**
"We prepare everything. You submit with one click."
(User still clicks "submit" on official platforms, but all preparation is done)

---

## 🔗 USEFUL RESOURCES

- **FranceConnect Partners:** https://franceconnect.gouv.fr/partenaires
- **API Particulier:** https://particulier.api.gouv.fr/
- **API Catalog:** https://api.gouv.fr/
- **DINUM (Digital Ministry):** https://www.numerique.gouv.fr/
- **CNIL (Data Protection):** https://www.cnil.fr/
- **Legal Framework:** https://www.legifrance.gouv.fr/

---

*Last Updated: February 2026*
*Status: Current based on publicly available documentation*
*Note: API availability and policies subject to change; verify before development*

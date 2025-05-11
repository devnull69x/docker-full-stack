# 🔮 GOD-TIER RULESET FOR AI CODING ASSISTANTS

> *A comprehensive guide for AI coding assistants that transforms ordinary code into production-hardened, battle-tested solutions that "magically work" every time.*

## 📋 Table of Contents
- [Project Awareness & Context](#-project-awareness--context)
- [Code Architecture & Structure](#-code-architecture--structure)
- [Development Standards](#-development-standards)
- [Testing & Quality Assurance](#-testing--quality-assurance)
- [Documentation & Knowledge Transfer](#-documentation--knowledge-transfer)
- [AI-Human Collaboration](#-ai-human-collaboration)
- [Performance Optimization](#-performance-optimization)
- [Security & Risk Management](#-security--risk-management)
- [Cloud-Native Development](#-cloud-native-development)
- [Industry-Specific Considerations](#-industry-specific-considerations)
- [Version Control & Collaboration](#-version-control--collaboration)
- [Debugging & Troubleshooting](#-debugging--troubleshooting)

## 🔄 Project Awareness & Context

### Core Principles
- **ALWAYS read project documentation first** before proposing solutions
  - Prioritize `PLANNING.md`, `README.md`, and `TASK.md` files
  - Understand the project architecture, goals, style, and constraints
- **Maintain project context** throughout the development process
  - Track the conversation history to avoid redundant suggestions
  - Reference previous decisions when proposing new solutions

### Implementation Guidelines
- **Before starting new work:**
  ```mermaid
  flowchart TD
    A[New Task/Conversation] --> B{Documentation Available?}
    B -->|Yes| C[Read Documentation]
    B -->|No| D[Request Overview]
    C --> E[Understand Current Architecture]
    D --> E
    E --> F[Confirm Understanding]
    F --> G[Begin Implementation]
  ```

- **Task tracking protocol:**
  - Check `TASK.md` before starting a new task
  - If the task isn't listed, add it with a brief description and today's date
  - Mark completed tasks immediately after finishing them
  - Add discovered sub-tasks under a "Discovered During Work" section

## 🏗 Code Architecture & Structure

### Core Principles
- **Design for extensibility** - code should accommodate future changes
- **Single Responsibility Principle** - each component does one thing well
- **Consistent patterns** across the entire codebase
- **Modular architecture** with clear separation of concerns

### Implementation Guidelines
- **File structure standards:**
  - Never create files longer than 500 lines
  - Organize by feature or domain rather than by technical function
  - Group related components, services, and tests together
  ```
  src/
  ├── features/
  │   ├── auth/
  │   │   ├── components/
  │   │   ├── services/
  │   │   ├── hooks/
  │   │   └── tests/
  │   └── dashboard/
  │       ├── components/
  │       └── ...
  ├── shared/
  │   ├── components/
  │   ├── utils/
  │   └── hooks/
  └── core/
      ├── api/
      └── config/
  ```

- **Import standards:**
  - Prefer relative imports within packages
  - Use absolute imports for cross-feature references
  - Group and order imports consistently:
    ```javascript
    // 1. External dependencies
    import React, { useState } from 'react';
    import { Container } from 'some-ui-lib';
    
    // 2. Internal modules (absolute imports)
    import { AppConfig } from 'core/config';
    
    // 3. Internal modules (relative imports)
    import { useAuth } from '../hooks/useAuth';
    import { Button } from './Button';
    ```

- **Technology-specific patterns:**
  - **React/Next.js:** Custom hooks for reusable logic, component composition over inheritance
  - **Go:** Follow standard project layout, use interfaces for abstraction
  - **Docker:** Multi-stage builds, minimal base images

## 🛠 Development Standards

### Core Principles
- **Consistency** across the entire codebase
- **Predictability** in behavior and structure
- **Maintainability** prioritized over clever solutions
- **Forward compatibility** with emerging standards

### Implementation Guidelines
- **Universal coding standards:**
  - Use consistent naming conventions (agree on camelCase vs snake_case)
  - Follow language-specific conventions rigorously
  - Implement proper error handling at all levels
  - Use strong typing wherever possible (TypeScript, Go's static typing)

- **Quality benchmarks:**
  - Production-ready code meets these criteria:
    ```
    ✅ Properly handles edge cases
    ✅ Includes comprehensive error handling
    ✅ Has appropriate logging
    ✅ Is performance optimized
    ✅ Has accompanying tests
    ✅ Is well-documented
    ```

- **"God-tier" code characteristics:**
  - Anticipates requirements before they're stated
  - Elegantly handles edge cases without bloat
  - Uses language/framework features in uniquely optimal ways
  - Maintains readability while being extremely concise
  - Incorporates defensive coding without paranoia
  - Example (JavaScript):
    ```javascript
    // Regular implementation
    function getFullName(user) {
      if (user) {
        return `${user.firstName || ''} ${user.lastName || ''}`.trim();
      }
      return '';
    }
    
    // God-tier implementation
    const getFullName = user => 
      user ? [user.firstName, user.lastName].filter(Boolean).join(' ') : '';
    ```

## 🧪 Testing & Quality Assurance

### Core Principles
- **Test-driven where appropriate** - tests guide implementation
- **Coverage is valuable but not the goal** - meaningful tests over quantity
- **Tests as documentation** - tests should clarify expected behavior

### Implementation Guidelines
- **Testing intensity: 3/5 (moderate to high)**
  - All core functionality must be tested
  - Critical paths require higher coverage
  - Business logic testing prioritized over UI testing

- **Testing hierarchy:**
  ```mermaid
  flowchart TD
    A[Unit Tests] -->|80% of test effort| B[Core Business Logic]
    A --> C[Utility Functions]
    D[Integration Tests] -->|15% of test effort| E[API Endpoints]
    D --> F[Service Interactions]
    G[E2E Tests] -->|5% of test effort| H[Critical User Flows]
  ```

- **Test requirements:**
  - Tests should live in a `/tests` folder mirroring the main app structure
  - Each feature needs at minimum:
    - 1 test for expected use
    - 1 edge case test
    - 1 failure case test
  - Test data should be generated programmatically where possible
  - Example (Jest):
    ```javascript
    describe('calculateTotal', () => {
      // Expected use case
      it('should calculate correct total with tax', () => {
        expect(calculateTotal(100, 0.1)).toBe(110);
      });
      
      // Edge case
      it('should handle zero amounts', () => {
        expect(calculateTotal(0, 0.1)).toBe(0);
      });
      
      // Failure case
      it('should throw error for negative amounts', () => {
        expect(() => calculateTotal(-10, 0.1)).toThrow('Amount cannot be negative');
      });
    });
    ```

## 📚 Documentation & Knowledge Transfer

### Core Principles
- **Self-documenting code** where possible
- **Documentation as a first-class citizen** - not an afterthought
- **Right level of detail** - concise but complete

### Implementation Guidelines
- **Code documentation standards:**
  - Every function/method needs a docstring using appropriate format
  - Non-obvious code requires inline comments
  - Complex logic needs a "Reason:" comment explaining the why, not just what

- **Google-style docstrings:**
  ```python
  def transfer_funds(source_account: Account, target_account: Account, amount: Decimal) -> bool:
      """
      Transfer funds between accounts with proper validation and transaction safety.
      
      Args:
          source_account: Account to withdraw funds from
          target_account: Account to deposit funds to
          amount: Amount to transfer (must be positive)
          
      Returns:
          bool: True if transfer was successful, False otherwise
          
      Raises:
          InsufficientFundsError: If source account has insufficient balance
          AccountFrozenError: If either account is frozen
      """
  ```

- **Project documentation:**
  - Update `README.md` when:
    - New features are added
    - Dependencies change
    - Setup steps are modified
  - Document architectural decisions in `ARCHITECTURE.md` or similar
  - Create decision logs for significant architectural choices

## 🤝 AI-Human Collaboration

### Core Principles
- **Clarity over assumptions** - request information when needed
- **Collaborative problem-solving** - guide rather than dictate
- **Educational approach** - explain the why behind recommendations

### Implementation Guidelines
- **Clarification protocol:**
  ```mermaid
  flowchart TD
    A[Receive Request] --> B{Is request clear?}
    B -->|Yes| C[Proceed with Solution]
    B -->|No| D[Request Clarification]
    D --> E[Provide 2-3 Example Directions]
    E --> F[User Response]
    F --> B
  ```

- **When asking for clarification:**
  - Always suggest possible directions
  - Provide concrete examples
  - Explain trade-offs between approaches
  - Example:
    ```
    I need more information about your authentication requirements. 
    
    Would you prefer:
    1. JWT-based auth with refresh tokens (good for scalability, stateless)
       Example: `const token = jwt.sign({ userId }, SECRET, { expiresIn: '1h' })`
    
    2. Session-based auth with Redis storage (better for security, easier revocation)
       Example: `req.session.userId = user.id // Stored in Redis`
    
    3. OAuth integration with social providers (faster implementation, delegate security)
       Example: `passport.authenticate('google', { scope: ['profile', 'email'] })`
    ```

- **Risk assessment approach:**
  - When security or ethical concerns arise, present options with clear risks
  - Allow user to make informed choices
  - Document decisions made
  - Example:
    ```
    The requested function could be vulnerable to SQL injection.
    
    Options:
    1. ✅ Recommended: Use parameterized queries (safer)
       `db.query('SELECT * FROM users WHERE id = ?', [userId])`
       
    2. ⚠️ Not recommended: Direct string interpolation (vulnerable)
       `db.query('SELECT * FROM users WHERE id = ' + userId)`
       
    Please choose which approach you'd prefer (I recommend option 1).
    ```

## ⚡ Performance Optimization

### Core Principles
- **Profile before optimizing** - identify real bottlenecks
- **Algorithm efficiency first** - optimize logic before micro-optimizations
- **Balance readability and performance** - document complex optimizations

### Implementation Guidelines
- **Performance checklist by layer:**
  
  **Frontend:**
  - Implement code-splitting and lazy loading
  - Optimize bundle sizes with tree-shaking
  - Use memoization for expensive computations
  - Virtualize long lists
  
  **Backend:**
  - Optimize database queries (indexing, query structure)
  - Implement appropriate caching strategies
  - Use connection pooling
  - Process batch operations asynchronously
  
  **Cross-cutting:**
  - Minimize network requests
  - Compress assets and responses
  - Use appropriate data structures for operations

- **Performance optimization example (React):**
  ```javascript
  // Before optimization
  function ProductList({ products }) {
    return (
      <div>
        {products.map(product => (
          <ProductCard key={product.id} product={product} />
        ))}
      </div>
    );
  }
  
  // After optimization
  const ProductCard = React.memo(({ product }) => {
    // Component implementation
  });
  
  function ProductList({ products }) {
    const memoizedProducts = useMemo(() => products, [products]);
    
    return (
      <div>
        {memoizedProducts.length > 100 ? (
          <VirtualizedList
            data={memoizedProducts}
            renderItem={({ item }) => <ProductCard product={item} />}
          />
        ) : (
          memoizedProducts.map(product => (
            <ProductCard key={product.id} product={product} />
          ))
        )}
      </div>
    );
  }
  ```

## 🔒 Security & Risk Management

### Core Principles
- **Security as a process**, not a feature
- **Defense in depth** - multiple layers of security
- **Principle of least privilege** - minimize access rights
- **Trust no input** - validate everything from external sources

### Implementation Guidelines
- **Security checklist:**
  - Input validation on both client and server
  - Output encoding to prevent XSS
  - Parameterized queries to prevent SQL injection
  - Proper authentication and authorization
  - HTTPS for all traffic
  - Secure password handling (hashing, not encryption)
  - Rate limiting on sensitive endpoints
  - CSRF protection
  - Security headers (CSP, HSTS, etc.)

- **Risk assessment matrix:**
  ```
  | Risk Level | Probability | Impact | Action                                |
  |------------|------------|--------|---------------------------------------|
  | Critical   | Any        | High   | Must fix before deployment            |
  | High       | High       | Medium | Should fix before deployment          |
  | Medium     | Medium     | Medium | Fix in next iteration                 |
  | Low        | Low        | Low    | Document and consider fixing later    |
  ```

- **Security-first code examples:**
  ```javascript
  // Authentication example with rate limiting
  const loginAttempts = {};
  
  app.post('/login', async (req, res) => {
    const { username } = req.body;
    
    // Rate limiting
    const userKey = `${username}:${req.ip}`;
    loginAttempts[userKey] = (loginAttempts[userKey] || 0) + 1;
    
    if (loginAttempts[userKey] > 5) {
      return res.status(429).json({ error: 'Too many attempts, try again later' });
    }
    
    // Authentication logic
    try {
      const user = await User.findOne({ username });
      if (!user) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }
      
      const isValid = await bcrypt.compare(req.body.password, user.password);
      if (!isValid) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }
      
      // Reset attempts on success
      delete loginAttempts[userKey];
      
      // Create token, session, etc.
      // ...
      
      return res.status(200).json({ token });
    } catch (error) {
      console.error('Login error:', error);
      return res.status(500).json({ error: 'Internal server error' });
    }
  });
  ```

## ☁️ Cloud-Native Development

### Core Principles
- **Design for horizontal scaling** from day one
- **Infrastructure as code** - nothing manual
- **Immutable infrastructure** - rebuild, don't modify
- **Observability built-in** - logs, metrics, traces

### Implementation Guidelines
- **Container best practices:**
  - Use multi-stage builds to minimize image size
  - Never run as root
  - Use specific versions of base images
  - Include health checks
  - Example `Dockerfile`:
    ```dockerfile
    # Build stage
    FROM node:16-alpine AS builder
    WORKDIR /app
    COPY package*.json ./
    RUN npm ci
    COPY . .
    RUN npm run build
    
    # Production stage
    FROM node:16-alpine
    WORKDIR /app
    COPY --from=builder /app/package*.json ./
    COPY --from=builder /app/node_modules ./node_modules
    COPY --from=builder /app/dist ./dist
    
    # Create non-root user
    RUN addgroup -g 1001 appuser && \
        adduser -u 1001 -G appuser -s /bin/sh -D appuser
    USER appuser
    
    # Health check
    HEALTHCHECK --interval=30s --timeout=3s \
      CMD wget -q --spider http://localhost:3000/health || exit 1
    
    EXPOSE 3000
    CMD ["node", "dist/main.js"]
    ```

- **Microservices design patterns:**
  - API Gateway pattern for client communication
  - Circuit Breaker pattern for resilience
  - CQRS for complex domains
  - Event Sourcing for audit trails and replay

- **Kubernetes-ready applications:**
  - Stateless where possible
  - Respect pod lifecycle events
  - Implement proper liveness and readiness probes
  - Handle graceful shutdowns

## 🏢 Industry-Specific Considerations

### Core Principles
- **Know the regulatory landscape** of the industry
- **Adapt patterns to domain requirements**
- **Balance compliance and user experience**

### Implementation Guidelines
- **Financial services:**
  - Implement double-entry accounting for financial transactions
  - Maintain comprehensive audit trails
  - Design for reconciliation processes
  - Example pattern:
    ```typescript
    interface Transaction {
      id: string;
      amount: number;
      type: 'CREDIT' | 'DEBIT';
      accountId: string;
      balanceBefore: number;
      balanceAfter: number;
      metadata: Record<string, any>;
      createdAt: Date;
      createdBy: string;
    }
    ```

- **Healthcare:**
  - Implement strict data access controls
  - Design for HIPAA compliance
  - Support audit logging for PHI access
  - Include emergency access procedures

- **E-commerce:**
  - Implement idempotent operations for payment processing
  - Design for inventory consistency
  - Build robust order state machines
  - Example order state flow:
    ```mermaid
    stateDiagram-v2
      [*] --> Created
      Created --> Processing: payment_received
      Processing --> Fulfilled: items_shipped
      Processing --> Canceled: cancel_requested
      Fulfilled --> Delivered: delivery_confirmed
      Fulfilled --> Returned: return_requested
      Returned --> [*]
      Delivered --> [*]
      Canceled --> [*]
    ```

## 🔄 Version Control & Collaboration

### Core Principles
- **Atomic commits** - one logical change per commit
- **Descriptive messages** - what, why, and how
- **Branch management** - clean history and isolation

### Implementation Guidelines
- **Branching strategy:**
  - `main` - production-ready code
  - `develop` - integration branch for features
  - `feature/*` - new features and non-urgent bug fixes
  - `hotfix/*` - urgent production fixes
  - `release/*` - release preparation

- **Commit message format:**
  ```
  <type>(<scope>): <subject>
  
  <body>
  
  <footer>
  ```
  Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`

- **Pull request process:**
  - Descriptive title and detailed description
  - Link to related issues
  - Documentation for reviewers
  - Tests for all new functionality
  - Example:
    ```markdown
    ## Feature: User Profile Image Upload
    
    This PR implements the user profile image upload feature with:
    - Frontend dropzone component
    - Image cropping and preview
    - Backend upload handling and storage
    - Image optimization pipeline
    
    Closes #123
    
    ### Testing Notes
    1. Try uploading various image formats (JPG, PNG, GIF)
    2. Test with large images (>5MB)
    3. Verify cropping functionality works across browsers
    
    ### Screenshots
    [Before/After screenshots]
    ```

## 🔍 Debugging & Troubleshooting

### Core Principles
- **Systematic approach** - not random changes
- **Evidence-based** - collect data before conclusions
- **Root cause analysis** - fix causes, not symptoms

### Implementation Guidelines
- **Debugging protocol:**
  ```mermaid
  flowchart TD
    A[Issue Reported] --> B[Reproduce the Issue]
    B --> C[Isolate the Scope]
    C --> D[Gather Relevant Data]
    D --> E[Form Hypothesis]
    E --> F[Test Hypothesis]
    F --> G{Problem Solved?}
    G -->|Yes| H[Document Solution]
    G -->|No| E
  ```

- **Debugging techniques by type:**
  - **Logic errors:** Logging, step-through debugging
  - **Performance issues:** Profiling, flame graphs
  - **Memory leaks:** Heap snapshots, memory profiling
  - **Concurrency bugs:** Race condition analysis, deadlock detection
  - **Network issues:** Request/response inspection, traffic analysis

- **Root cause analysis template:**
  ```
  Issue: [Brief description]
  
  Symptoms:
  - [Observable behavior]
  - [Error messages]
  - [Affected components]
  
  Analysis:
  1. [Investigation step]
  2. [Findings]
  3. [Evidence]
  
  Root Cause:
  [Fundamental issue that led to the problem]
  
  Solution:
  [Implemented fix with code reference]
  
  Prevention:
  [Changes to prevent recurrence]
  ```

---

## 🌟 Becoming Truly God-Tier

The difference between professional code and god-tier code isn't just technical excellence—it's a mindset. God-tier developers:

1. **Think in systems**, not just components
2. **Anticipate the next five requirements** before they're asked for
3. **Choose the right abstraction level** for every problem
4. **Balance theoretical purity with practical constraints**
5. **Leave code better than they found it**

True god-tier solutions don't just work—they feel like magic because they elegantly solve problems users didn't even know they had, while remaining maintainable, performant, and secure.

---

*This ruleset represents the distilled wisdom of decades of professional software development, hardened through real-world experience and optimized for the unique collaboration between AI assistants and human developers.*

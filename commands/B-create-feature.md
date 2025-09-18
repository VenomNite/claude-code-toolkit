---
model: sonnet
description: Scaffolding avanzado de features con auto-detección de arquitectura, templates inteligentes y matrices de planificación estructurada
argument-hint: [feature-name] [--type api|ui|fullstack|service] [--arch auto|detect] [--scaffold basic|advanced|enterprise]
allowed-tools: Read, Write, Edit, Bash, Glob
---

# B-Create Feature - Intelligent Feature Scaffolding with Architecture Detection

Scaffolding inteligente de features con detección automática de arquitectura: $ARGUMENTS

## Contexto Automático & Architecture Detection
- Root: !`git rev-parse --show-toplevel 2>/dev/null || pwd`
- Architecture detection: !`find . -name "*.json" -o -name "*.xml" -o -name "*.toml" -o -name "*.yaml" | grep -E "(package|pom|cargo|docker)" | head -5`
- Project structure: !`find . -maxdepth 3 -type d | grep -E "(src|components|features|services|controllers)" | head -10`
- Framework detection: !`ls -la | grep -E "(package\.json|pom\.xml|Cargo\.toml|requirements\.txt|composer\.json)"`

## 🏗️ Advanced Architecture Intelligence Mode

### **🎯 INITIALIZE INTELLIGENT SCAFFOLDING**

**Feature Name**: $ARGUMENTS
**Auto-Architecture Detection**: Detectar stack, patrones y estructura del proyecto
**Scaffolding Level**: Auto-determinar complejidad y templates necesarios
**Integration Strategy**: Detectar puntos de integración y dependencias

### **1. Project Architecture Detection Matrix (Automated)**

#### **Architecture Intelligence Matrix**
| Detection Layer | Technology | Version | Pattern | Confidence | Scaffolding Strategy |
|-----------------|------------|---------|---------|------------|---------------------|
| **Build System** | [Maven/Gradle/npm/etc] | [Version] | [Monolith/Micro] | [%] | [Template selection] |
| **Backend Framework** | [Spring/Express/Django] | [Version] | [MVC/Clean/Hexagonal] | [%] | [Backend scaffolding] |
| **Frontend Framework** | [React/Vue/Angular] | [Version] | [SPA/SSR/JAMstack] | [%] | [Frontend scaffolding] |
| **Database Layer** | [JPA/Prisma/SQLAlchemy] | [Version] | [Repository/DAO/ORM] | [%] | [Data layer scaffolding] |
| **Testing Framework** | [JUnit/Jest/PyTest] | [Version] | [Unit/Integration] | [%] | [Test scaffolding] |
| **Deployment** | [Docker/K8s/Cloud] | [Version] | [Container/Serverless] | [%] | [Deploy scaffolding] |

#### **Auto-Detection Commands**
```bash
# Package Manager & Build System Detection
if [ -f "package.json" ]; then STACK="node"; MANAGER="npm"
elif [ -f "pom.xml" ]; then STACK="java"; MANAGER="maven"
elif [ -f "Cargo.toml" ]; then STACK="rust"; MANAGER="cargo"
elif [ -f "requirements.txt" ]; then STACK="python"; MANAGER="pip"
elif [ -f "composer.json" ]; then STACK="php"; MANAGER="composer"
fi

# Framework Detection Patterns
grep -r "spring-boot" . && FRAMEWORK="spring-boot"
grep -r "react" package.json && FRONTEND="react"
grep -r "vue" package.json && FRONTEND="vue"
grep -r "express" package.json && BACKEND="express"
```

### **2. Feature Planning Matrix (Intelligent)**

#### **Feature Scope Analysis Matrix**
| Feature Aspect | Complexity | Dependencies | Integration Points | Scaffolding Needed | Architecture Impact |
|----------------|------------|--------------|-------------------|-------------------|-------------------|
| **Data Layer** | [Simple/Complex] | [Database/ORM deps] | [Existing models] | [Entities/DTOs/Repos] | [Schema changes] |
| **Business Logic** | [CRUD/Complex] | [Service deps] | [Existing services] | [Services/Validators] | [Domain impact] |
| **API Layer** | [REST/GraphQL/gRPC] | [Web framework] | [Existing endpoints] | [Controllers/Resolvers] | [API design] |
| **Frontend** | [Component/Page/App] | [UI framework] | [Existing components] | [Components/Pages/State] | [UI architecture] |
| **Testing** | [Unit/Integration/E2E] | [Test frameworks] | [Test utilities] | [Test suites/Mocks] | [Test strategy] |
| **Security** | [Auth/RBAC/Validation] | [Security framework] | [Auth system] | [Guards/Middleware] | [Security model] |

### **3. Intelligent Template Selection (Auto-Adaptive)**

#### **Template Matrix by Architecture**
| Architecture Pattern | Backend Template | Frontend Template | Database Template | Test Template | Config Template |
|---------------------|------------------|-------------------|-------------------|---------------|-----------------|
| **Spring Boot MVC** | RestController + Service | React/Thymeleaf | JPA Entity + Repository | JUnit + MockMvc | application.yml |
| **Node.js Express** | Router + Controller | React/Vue SPA | Prisma/Sequelize | Jest + Supertest | .env + config |
| **Django REST** | ViewSet + Serializer | React/Vue SPA | Django Model | pytest + DRF test | settings.py |
| **Laravel** | Controller + Model | Blade/Vue | Eloquent Model | PHPUnit + Feature | config/app.php |
| **FastAPI** | Router + Pydantic | React/Vue SPA | SQLAlchemy Model | pytest + TestClient | config.py |

### **4. Advanced Scaffolding Generation (Stack-Aware)**

#### **Backend Scaffolding Templates**

##### **Spring Boot Template (Java)**
```java
// Auto-generated based on detected Spring Boot version
@RestController
@RequestMapping("/api/v1/${feature-name-kebab}")
@Validated
@Slf4j
public class ${FeatureName}Controller {

    private final ${FeatureName}Service ${featureName}Service;

    public ${FeatureName}Controller(${FeatureName}Service ${featureName}Service) {
        this.${featureName}Service = ${featureName}Service;
    }

    @GetMapping
    public ResponseEntity<Page<${FeatureName}Response>> getAll(
            @PageableDefault Pageable pageable) {
        // Auto-generated CRUD with pagination
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<${FeatureName}Response> create(
            @Valid @RequestBody ${FeatureName}Request request) {
        // Auto-generated creation with validation
    }
}

@Entity
@Table(name = "${feature_name_snake}")
public class ${FeatureName} {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    // Auto-generated fields based on feature type
}

@Service
@Transactional
public class ${FeatureName}Service {
    // Auto-generated business logic template
}
```

##### **Node.js Express Template**
```javascript
// Auto-generated based on detected Express version
const express = require('express');
const { body, validationResult } = require('express-validator');
const ${featureName}Service = require('../services/${featureName}Service');

const router = express.Router();

// GET /api/v1/${feature-name-kebab}
router.get('/', async (req, res, next) => {
    try {
        // Auto-generated CRUD operations
    } catch (error) {
        next(error);
    }
});

// Auto-generated validation middleware
const validate${FeatureName} = [
    // Auto-generated validation rules
];

module.exports = router;
```

#### **Frontend Scaffolding Templates**

##### **React Component Template**
```jsx
// Auto-generated based on detected React version and patterns
import React, { useState, useEffect } from 'react';
import { use${FeatureName}s } from '../hooks/use${FeatureName}s';
import { ${FeatureName}Form } from './components/${FeatureName}Form';
import { ${FeatureName}List } from './components/${FeatureName}List';

export const ${FeatureName}Page = () => {
    const { ${featureName}s, loading, error, create${FeatureName}, update${FeatureName} } = use${FeatureName}s();

    return (
        <div className="${feature-name-kebab}-page">
            {/* Auto-generated component structure */}
        </div>
    );
};
```

### **5. Database Schema Generation (Auto-Adaptive)**

#### **Database Schema Matrix**
| Database Type | Schema Template | Migration Template | Seed Template | Index Strategy | Relationship Pattern |
|---------------|-----------------|-------------------|---------------|----------------|-------------------|
| **PostgreSQL** | CREATE TABLE with constraints | Flyway/Liquibase migration | INSERT statements | B-tree/GIN indexes | FK constraints |
| **MySQL** | CREATE TABLE with InnoDB | MySQL migration script | Test data inserts | B-tree indexes | FK relationships |
| **MongoDB** | Mongoose schema | Migration script | Sample documents | Compound indexes | Document references |
| **SQLite** | CREATE TABLE simple | ALTER TABLE script | Basic test data | Simple indexes | Basic relationships |

#### **Auto-Generated Migration Template**
```sql
-- Auto-generated based on detected database and feature
-- Migration: V1__Create_${feature_name_snake}_table.sql

CREATE TABLE ${feature_name_snake} (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),

    -- Auto-generated constraints based on feature type
    CONSTRAINT uk_${feature_name_snake}_name UNIQUE (name),
    CONSTRAINT ck_${feature_name_snake}_status CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

-- Auto-generated indexes
CREATE INDEX idx_${feature_name_snake}_status ON ${feature_name_snake}(status);
CREATE INDEX idx_${feature_name_snake}_created_at ON ${feature_name_snake}(created_at);
```

### **6. Testing Strategy Matrix (Comprehensive)**

#### **Test Suite Generation Matrix**
| Test Type | Framework | Template | Coverage Target | Mock Strategy | Integration Points |
|-----------|-----------|----------|-----------------|---------------|-------------------|
| **Unit Tests** | [Detected framework] | Class/function tests | 80%+ | Service mocks | Business logic |
| **Integration** | [API testing framework] | HTTP endpoint tests | 70%+ | Database/external mocks | API contracts |
| **Repository** | [Database testing] | Data layer tests | 90%+ | Test database | Data operations |
| **Component** | [Frontend testing] | UI component tests | 70%+ | Props/state mocks | User interactions |
| **E2E** | [Browser testing] | User workflow tests | 60%+ | Full system | Critical user paths |

#### **Auto-Generated Test Templates**
```java
// Spring Boot Test Template
@SpringBootTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@Testcontainers
class ${FeatureName}IntegrationTest {

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:15")
            .withDatabaseName("testdb")
            .withUsername("test")
            .withPassword("test");

    @Test
    @DisplayName("Should create ${featureName} successfully")
    void shouldCreate${FeatureName}Successfully() {
        // Auto-generated test scenarios
    }
}
```

### **7. Configuration & Environment Setup (Intelligent)**

#### **Configuration Generation Matrix**
| Config Type | Template | Environment | Security | Validation | Documentation |
|-------------|----------|-------------|----------|------------|---------------|
| **Development** | Local config | Dev database/services | Basic auth | Loose validation | Dev setup guide |
| **Testing** | Test config | Test containers | Mock auth | Strict validation | Test data setup |
| **Staging** | Stage config | Staging services | Real auth | Production validation | Deploy guide |
| **Production** | Prod config | Prod services | Full security | Strict validation | Ops runbook |

### **8. Scaffolding Execution Matrix (Automated)**

#### **File Generation Matrix**
| Component | File Pattern | Template Source | Dependencies | Validation | Integration |
|-----------|--------------|-----------------|--------------|------------|-------------|
| **Controller** | `${stack}/controllers/${FeatureName}Controller.ext` | [Stack template] | [Framework deps] | [Syntax check] | [Route registration] |
| **Service** | `${stack}/services/${FeatureName}Service.ext` | [Service template] | [Business deps] | [Logic check] | [DI registration] |
| **Model** | `${stack}/models/${FeatureName}.ext` | [Model template] | [ORM deps] | [Schema check] | [Migration link] |
| **Test** | `${stack}/tests/${FeatureName}Test.ext` | [Test template] | [Test framework] | [Test validity] | [Suite registration] |

### **9. Project Integration Strategy (Smart)**

#### **Integration Points Matrix**
| Integration Type | Detection Method | Integration Strategy | Conflict Resolution | Validation Method | Rollback Strategy |
|------------------|------------------|---------------------|-------------------|-------------------|-------------------|
| **Routing** | Route file analysis | Auto-register routes | Route conflict check | Route testing | Route removal |
| **Dependencies** | Package file analysis | Auto-add dependencies | Version conflict resolution | Dependency check | Version rollback |
| **Configuration** | Config file analysis | Merge configurations | Config conflict resolution | Config validation | Config restore |
| **Database** | Schema analysis | Schema migration | Migration conflict check | Migration test | Migration rollback |

### **10. Quality Assurance Matrix (Built-in)**

#### **Quality Gates Matrix**
| Quality Gate | Check Method | Success Criteria | Fix Strategy | Automation Level | Reporting |
|-------------|--------------|------------------|--------------|------------------|-----------|
| **Syntax Check** | Linter/compiler | No syntax errors | Auto-fix/manual | Full automation | Error report |
| **Style Check** | Code formatter | Style compliance | Auto-format | Full automation | Style report |
| **Security Check** | Security scanner | No vulnerabilities | Manual review | Semi-automation | Security report |
| **Performance** | Basic benchmarks | Meets thresholds | Optimization guide | Manual | Performance report |
| **Documentation** | Doc generator | Complete docs | Doc templates | Semi-automation | Coverage report |

### **11. Advanced Feature Types (Specialized Templates)**

#### **Feature Type Templates Matrix**
| Feature Type | Backend Pattern | Frontend Pattern | Database Pattern | Test Pattern | Security Pattern |
|--------------|-----------------|------------------|------------------|--------------|-------------------|
| **CRUD API** | REST controller | List/Form components | Standard entity | Full CRUD tests | Standard auth |
| **Authentication** | Auth service | Login/Register forms | User/Role entities | Security tests | JWT/OAuth setup |
| **File Upload** | Upload controller | Drag-drop component | File entity | Upload tests | File validation |
| **Real-time** | WebSocket service | WebSocket component | Event entity | WebSocket tests | Connection auth |
| **Reporting** | Report service | Chart components | Aggregate queries | Report tests | Data access control |
| **Search** | Search service | Search component | Search indexes | Search tests | Search permissions |

### **12. Deployment & DevOps Integration (Smart)**

#### **DevOps Scaffolding Matrix**
| DevOps Component | Template | Integration | Automation | Monitoring | Scaling |
|------------------|----------|-------------|------------|------------|---------|
| **Docker** | Dockerfile + compose | Build integration | CI pipeline | Health checks | Horizontal scaling |
| **Kubernetes** | K8s manifests | Helm charts | GitOps | Prometheus | Auto-scaling |
| **CI/CD** | Pipeline config | Test integration | Deploy automation | Pipeline monitoring | Blue-green deploy |
| **Monitoring** | Metrics config | APM integration | Alert rules | Dashboard setup | Performance scaling |

### **13. Documentation Generation (Auto-Generated)**

#### **Documentation Matrix**
| Doc Type | Template | Generation Method | Audience | Update Strategy | Integration |
|----------|----------|-------------------|----------|-----------------|-------------|
| **API Docs** | OpenAPI/Swagger | Code annotation scan | Developers | Auto-generation | API explorer |
| **Component Docs** | Storybook | Component analysis | UI developers | Component stories | Living docs |
| **Architecture** | Diagrams + text | Code structure analysis | Team/stakeholders | Manual updates | Architecture views |
| **User Guide** | Step-by-step | Feature flow analysis | End users | Manual creation | User portal |

### **14. DoD (Definition of Done) - Feature Creation**
- ✅ Architecture auto-detectada y templates aplicados correctamente
- ✅ Feature scaffolding generado según patrones del proyecto
- ✅ Base de datos, migraciones y seeds creados automáticamente
- ✅ Tests unitarios, integración y E2E generados y funcionales
- ✅ Documentación automática generada (API, componentes, arquitectura)
- ✅ Configuraciones de desarrollo, testing y producción creadas
- ✅ Integración con CI/CD y DevOps configurada
- ✅ Quality gates pasados (syntax, style, security, performance)
- ✅ Feature branch creado y primer commit realizado
- ✅ Pull request template y descripción generados

## Usage Examples

```bash
# Feature API completa con auto-detección
/B-create-feature "user-management" --type fullstack --arch auto --scaffold advanced

# Feature de servicio backend únicamente
/B-create-feature "notification-service" --type service --arch detect --scaffold enterprise

# Feature UI con detección de arquitectura frontend
/B-create-feature "dashboard-widgets" --type ui --arch auto --scaffold basic
```

**Enhanced Features**: Auto architecture detection, intelligent template selection, stack-aware scaffolding, integrated testing, DevOps automation, quality gates, documentation generation.

**Automation**: Complete project analysis, template selection, file generation, dependency management, configuration setup, integration testing.

**Output**: Complete feature implementation with all layers (data, service, API, UI, tests, docs, config) following detected project patterns and best practices.
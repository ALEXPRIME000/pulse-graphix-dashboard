# Nexus AI Academy — Project Brief

## What It Is

Nexus AI Academy is a full-featured Learning Management System (LMS) built primarily for the French-speaking market. It's a web application where users can browse, enroll in, and complete online courses with rich multimedia content, progress tracking, quizzes, certificates, and AI-powered tutoring.

**Live tech stack**: Next.js 15, TypeScript, Prisma ORM, SQLite/PostgreSQL, NextAuth v5, Tailwind CSS, Stripe payments, OpenAI integration.

**Languages**: French (primary), English, German, Spanish — full i18n support.

## What Makes It Special: AI-Powered Course Creation

The core differentiator of this platform is that **administrators don't manually create courses**. Instead:

1. An admin provides high-level course information (topic, target audience, desired structure)
2. AI agents automatically generate the full course structure — modules, lessons, content sections, quizzes, case studies, and exercises
3. The system creates all the structured content needed for a world-class tutorial experience
4. The generated course is uploaded and published to the platform, ready for students

This means the platform can scale course creation dramatically without requiring subject matter experts to manually author every lesson, section, and quiz. The AI handles the heavy lifting of content structuring and generation.

### Course Import Pipelines

The system supports multiple ways to get courses into the platform:

- **HTML Import**: Upload structured HTML files that get parsed into courses, modules, and lessons with content blocks
- **Airtable Integration**: Sync course data from Airtable bases, including structured lessons with sections, video prompts, case studies, and exercise projects
- **Unified Bulk Import**: Import multiple courses at once through a single interface
- **Structured Lesson System**: A rich content model that goes beyond basic lessons — each lesson can have typed sections (Introduction, Concept, Example, Practice, etc.), visual elements, interactive components, video production specs, case studies, and step-by-step exercise projects

## Platform Features

### For Students
- Browse and search a course catalog
- Enroll in courses (free or paid via Stripe)
- Learn through rich multimedia lessons (HTML, video, audio, code, interactive content)
- Track progress at the lesson, module, and course level
- Take quizzes and assessments
- Download course resources
- Chat with AI-powered course assistants (each course can have its own AI tutor)
- Book 1-on-1 sessions with human instructors
- Earn certificates upon course completion

### For Instructors
- Create and manage their own courses
- Import course content from HTML files
- Set availability for 1-on-1 booking sessions
- Configure session types and pricing
- View student enrollments and progress

### For Administrators
- Full user management (roles: Student, Instructor, Admin)
- Course approval and moderation system
- Bulk course import interface
- AI-powered course generation
- Analytics dashboard
- Content moderation tools
- Coupon and promotion management
- Email campaign system

## How the Course Structure Works

```
Course
├── Module 1
│   ├── Lesson 1
│   │   ├── Content Block (HTML text)
│   │   ├── Content Block (Video)
│   │   ├── Content Block (Quiz)
│   │   └── Content Block (Code example)
│   ├── Lesson 2
│   └── Assessment (Module quiz)
├── Module 2
│   └── ...
└── AI Instructor (chatbot tutor for this course)
```

Each lesson can also have a **Structured Lesson** record that provides:
- Typed sections (Introduction, Concept, Demonstration, Practice, Conclusion)
- Visual element specifications (images, diagrams, animations)
- Interactive elements (quizzes, reflection prompts, code editors)
- Video production prompts (scene descriptions, graphics specs, B-roll suggestions)
- Case studies with background, challenge, solution, and results
- Exercise projects broken into guided steps

## Payment & Business Model

- Stripe integration for course purchases (EUR currency, French VAT compliance)
- Support for coupons, promotions, and time-limited discounts
- Course packages/bundles
- Instructor session booking with configurable pricing
- Subscription tiers (Free, Premium, Enterprise)

## Authentication & Access Control

- Email/password registration with email verification
- OAuth via Google and GitHub
- Role-based access (Student, Instructor, Admin)
- Course enrollment verification — students must be enrolled to access learning content
- Profile completion enforcement after registration
- Protected admin routes with role checks

## Real-Time & AI Features

- **AI Course Assistants**: Each course can have an AI instructor powered by OpenAI that students can chat with for help
- **Firebase Chat**: Real-time messaging infrastructure
- **Pusher**: Real-time event broadcasting

## Current State

The platform is functional with:
- Complete auth system with three test user roles
- Course browsing, enrollment, and learning interface
- Course import from HTML and Airtable
- Progress tracking
- Payment integration
- Booking system for instructor sessions
- Admin dashboard
- i18n support for 4 languages

The main area of active development is the AI-powered course generation pipeline — making it seamless for admins to go from a course idea to a fully structured, published course with minimal manual effort.

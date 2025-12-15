# 📁 ფაილების სტრუქტურის წესები

## 🎯 ძირითადი პრინციპები

> **მაქსიმალურად გამოიყენე Next.js-ის უპირატესობები!**

### Next.js Best Practices:

| პრინციპი | აღწერა |
|----------|--------|
| 🧩 **კომპონენტიზაცია** | ყველაფერი დაშალე მცირე, reusable კომპონენტებად |
| ⚡ **Server Components** | გამოიყენე Server Components სადაც შესაძლებელია (default) |
| 🔄 **Client Components** | `'use client'` მხოლოდ საჭიროების შემთხვევაში (interactivity) |
| 📦 **Code Splitting** | Next.js ავტომატურად აკეთებს - არ გადატვირთო ერთ კომპონენტს |
| 🖼️ **Image Optimization** | გამოიყენე `next/image` ყველა სურათისთვის |
| 🔗 **Link Component** | გამოიყენე `next/link` ნავიგაციისთვის |
| 📝 **Metadata API** | SEO-სთვის გამოიყენე `generateMetadata` |

### რა უნდა დაიშალოს კომპონენტებად:

✅ **აუცილებელია დაშლა:**
- Header, Footer, Sidebar, Navigation
- Card, Button, Input, Modal, Dropdown
- Form sections (თითოეული input group)
- List items (რომლებიც მეორდება)
- Loading states, Error states
- Icons, Badges, Avatars

❌ **არ არის საჭირო დაშლა:**
- ერთჯერადი, მარტივი ელემენტები
- 2-3 ხაზიანი მარკაპი რომელიც არ მეორდება

---

## სავალდებულო წესები

### 1. კომპონენტების ორგანიზება

❌ **არასწორი** - TSX ფაილი პირდაპირ components ფოლდერში:
```
src/
  components/
    Button.tsx        ❌ არასწორია!
    Card.tsx          ❌ არასწორია!
```

✅ **სწორი** - TSX ფაილი სუბ-ფოლდერში:
```
src/
  components/
    buttons/
      Button.tsx      ✅ სწორია!
    cards/
      Card.tsx        ✅ სწორია!
```

### 2. მსგავსი კომპონენტების დაჯგუფება

თუ ერთ სუბ-ფოლდერში მრავალი ერთნაირი ტიპის კომპონენტია, დააჯგუფე sub-sub ფოლდერებში:

```
src/
  components/
    forms/
      inputs/
        TextInput.tsx
        NumberInput.tsx
        EmailInput.tsx
      selects/
        Dropdown.tsx
        MultiSelect.tsx
        Autocomplete.tsx
      buttons/
        SubmitButton.tsx
        ResetButton.tsx
```

---

## �️ Routes / როუტების ორგანიზება

### page.tsx წესები

`page.tsx` ფაილში **მხოლოდ კომპონენტის გამოძახება** უნდა მოხდეს - სუფთად, დამატებითი სტილების და ლოგიკის გარეშე.

❌ **არასწორი** - page.tsx-ში სტილები და ლოგიკა:
```tsx
// app/books/page.tsx - არასწორია!
export default function BooksPage() {
  const [books, setBooks] = useState([]);
  
  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold">წიგნები</h1>
      {books.map(book => <div key={book.id}>{book.title}</div>)}
    </div>
  );
}
```

✅ **სწორი** - page.tsx-ში მხოლოდ კომპონენტის გამოძახება:
```tsx
// app/books/page.tsx - სწორია!
import BooksPage from '@/components/pages/books/BooksPage';

export default function Page() {
  return <BooksPage />;
}
```

### როუტების ფოლდერების სტრუქტურა

როუტებისთვის გამოიყენე იგივე ფოლდერების სისტემა, რაც კომპონენტებში:

```
src/
├── app/
│   ├── globals.css
│   ├── layout.tsx
│   ├── page.tsx
│   │
│   ├── books/                     # წიგნების როუტები
│   │   ├── page.tsx               # /books
│   │   └── [id]/
│   │       └── page.tsx           # /books/:id
│   │
│   ├── auth/                      # ავტორიზაციის როუტები
│   │   ├── login/
│   │   │   └── page.tsx           # /auth/login
│   │   └── register/
│   │       └── page.tsx           # /auth/register
│   │
│   └── dashboard/                 # დეშბორდის როუტები
│       ├── page.tsx               # /dashboard
│       └── settings/
│           └── page.tsx           # /dashboard/settings
│
└── components/
    └── pages/                     # 🔵 გვერდების კომპონენტები
        ├── home/
        │   └── HomePage.tsx
        ├── books/
        │   ├── BooksPage.tsx
        │   └── BookDetailsPage.tsx
        └── auth/
            ├── LoginPage.tsx
            └── RegisterPage.tsx
```

---
## 🔐 Protected Routes / დაცული როუტები

### დაცვის დონეები

| დონე | როუტი | აღწერა |
|------|-------|--------|
| 🟢 **Public** | `/`, `/books`, `/auth/*` | ყველას აქვს წვდომა |
| 🟡 **Authenticated** | `/dashboard/*`, `/profile/*` | მხოლოდ ავტორიზებული მომხმარებლები |
| 🔴 **Admin** | `/admin/*` | მხოლოდ ადმინისტრატორები |
| 🟣 **Role-based** | `/moderator/*` | სპეციფიური როლის მქონე მომხმარებლები |

### დაცული როუტების სტრუქტურა

```
src/
├── app/
│   ├── (public)/                  # 🟢 საჯარო როუტები (group)
│   │   ├── page.tsx
│   │   ├── books/
│   │   └── auth/
│   │
│   ├── (protected)/               # 🟡 დაცული როუტები (group)
│   │   ├── layout.tsx             # ← Auth check აქ!
│   │   ├── dashboard/
│   │   └── profile/
│   │
│   └── (admin)/                   # 🔴 ადმინ როუტები (group)
│       ├── layout.tsx             # ← Admin check აქ!
│       └── admin/
│           ├── page.tsx
│           ├── users/
│           └── settings/
│
├── middleware.ts                  # 🛡️ Edge middleware - პირველი დაცვის ხაზი
│
└── lib/
    └── auth/
        ├── checkAuth.ts           # Auth validation
        └── checkRole.ts           # Role validation
```

### Middleware (პირველი დაცვის ხაზი)

```typescript
// src/middleware.ts
import { createServerClient } from '@supabase/ssr';
import { NextResponse, type NextRequest } from 'next/server';

// დაცული როუტების პატერნები
const protectedRoutes = ['/dashboard', '/profile'];
const adminRoutes = ['/admin'];

export async function middleware(request: NextRequest) {
  const response = NextResponse.next();
  
  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value, options }) =>
            response.cookies.set(name, value, options)
          );
        },
      },
    }
  );

  const { data: { user } } = await supabase.auth.getUser();
  const pathname = request.nextUrl.pathname;

  // 🟡 Protected routes check
  if (protectedRoutes.some(route => pathname.startsWith(route))) {
    if (!user) {
      return NextResponse.redirect(new URL('/auth/login', request.url));
    }
  }

  // 🔴 Admin routes check
  if (adminRoutes.some(route => pathname.startsWith(route))) {
    if (!user) {
      return NextResponse.redirect(new URL('/auth/login', request.url));
    }
    
    // Check admin role from user metadata or database
    const isAdmin = user.user_metadata?.role === 'admin';
    if (!isAdmin) {
      return NextResponse.redirect(new URL('/unauthorized', request.url));
    }
  }

  return response;
}

export const config = {
  matcher: ['/dashboard/:path*', '/profile/:path*', '/admin/:path*'],
};
```

### Layout-ში დაცვა (მეორე დაცვის ხაზი)

```typescript
// src/app/(protected)/layout.tsx
import { redirect } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';

export default async function ProtectedLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect('/auth/login');
  }

  return <>{children}</>;
}
```

### Admin Layout

```typescript
// src/app/(admin)/layout.tsx
import { redirect } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';

export default async function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect('/auth/login');
  }

  // Check admin role
  const { data: profile } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', user.id)
    .single();

  if (profile?.role !== 'admin') {
    redirect('/unauthorized');
  }

  return <>{children}</>;
}
```

### დაცვის საუკეთესო პრაქტიკები

| წესი | აღწერა |
|------|--------|
| 🛡️ | **Middleware** - პირველი დაცვის ხაზი (Edge-ზე) |
| 🔒 | **Layout** - მეორე დაცვის ხაზი (Server-side) |
| 🔐 | **API Routes** - ყოველთვის შეამოწმე auth სერვერზე |
| 🚫 | **არასოდეს** ენდო მხოლოდ client-side დაცვას |
| 📝 | **Row Level Security (RLS)** - Supabase-ში ჩართე RLS |
| 🔑 | **Role-based** - როლები შეინახე DB-ში, არა JWT-ში |

---
## �📊 გრაფიკული სტრუქტურა

```
src/
├── app/
│   ├── globals.css
│   ├── layout.tsx
│   └── page.tsx
│
└── components/                    # 🔴 აქ TSX ფაილი არ იქმნება!
    │
    ├── ui/                        # UI კომპონენტები
    │   ├── buttons/
    │   │   ├── PrimaryButton.tsx
    │   │   ├── SecondaryButton.tsx
    │   │   └── IconButton.tsx
    │   │
    │   ├── cards/
    │   │   ├── ProductCard.tsx
    │   │   └── UserCard.tsx
    │   │
    │   └── inputs/
    │       ├── TextInput.tsx
    │       └── SearchInput.tsx
    │
    ├── layout/                    # Layout კომპონენტები
    │   ├── header/
    │   │   └── Header.tsx
    │   ├── footer/
    │   │   └── Footer.tsx
    │   └── sidebar/
    │       └── Sidebar.tsx
    │
    └── features/                  # Feature-სპეციფიური კომპონენტები
        ├── auth/
        │   ├── LoginForm.tsx
        │   └── RegisterForm.tsx
        │
        └── books/
            ├── BookList.tsx
            └── BookDetails.tsx
```

---

## 🗄️ მონაცემთა ბაზა - Supabase

პროექტში ვიყენებთ **Supabase**-ს როგორც მონაცემთა ბაზას.

```
src/
└── lib/
    └── supabase/
        ├── client.ts             # Supabase client (browser)
        └── server.ts             # Supabase client (server)
```

### Supabase Client მაგალითი:

```typescript
// src/lib/supabase/client.ts
import { createBrowserClient } from '@supabase/ssr';

export function createClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  );
}
```

### Environment Variables (Supabase):

```env
NEXT_PUBLIC_SUPABASE_URL=your-project-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

---

## 🌐 API / ბაზასთან ურთიერთობა

### Axios-ის გამოყენება

ბაზასთან ან API-სთან ურთიერთობისას **სავალდებულოა Axios-ის გამოყენება**.

```
src/
├── lib/
│   └── axios/
│       └── axiosInstance.ts      # Axios კონფიგურაცია
│
└── services/
    ├── api/
    │   ├── bookService.ts        # წიგნების API
    │   └── userService.ts        # მომხმარებლების API
    │
    └── types/
        └── apiTypes.ts           # API ტიპები
```

### Axios კონფიგურაციის მაგალითი:

```typescript
// src/lib/axios/axiosInstance.ts
import axios from 'axios';

const axiosInstance = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL,
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json',
  },
});

export default axiosInstance;
```

### Service მაგალითი:

```typescript
// src/services/api/bookService.ts
import axiosInstance from '@/lib/axios/axiosInstance';

export const bookService = {
  getAll: () => axiosInstance.get('/books'),
  getById: (id: string) => axiosInstance.get(`/books/${id}`),
  create: (data: BookData) => axiosInstance.post('/books', data),
  update: (id: string, data: BookData) => axiosInstance.put(`/books/${id}`, data),
  delete: (id: string) => axiosInstance.delete(`/books/${id}`),
};
```

---

## � State Management / მონაცემთა მიმოცვლა

### Context API-ის გამოყენება

კომპონენტებს შორის მონაცემთა მიმოცვლისას **სავალდებულოა Context API-ის გამოყენება**.

```
src/
└── context/
    ├── auth/
    │   └── AuthContext.tsx       # ავტორიზაციის კონტექსტი
    ├── theme/
    │   └── ThemeContext.tsx      # თემის კონტექსტი
    └── books/
        └── BooksContext.tsx      # წიგნების კონტექსტი
```

### Context-ის მაგალითი:

```typescript
// src/context/books/BooksContext.tsx
'use client';

import { createContext, useContext, useState, ReactNode } from 'react';

interface Book {
  id: string;
  title: string;
  author: string;
}

interface BooksContextType {
  books: Book[];
  addBook: (book: Book) => void;
  removeBook: (id: string) => void;
}

const BooksContext = createContext<BooksContextType | undefined>(undefined);

export function BooksProvider({ children }: { children: ReactNode }) {
  const [books, setBooks] = useState<Book[]>([]);

  const addBook = (book: Book) => {
    setBooks((prev) => [...prev, book]);
  };

  const removeBook = (id: string) => {
    setBooks((prev) => prev.filter((book) => book.id !== id));
  };

  return (
    <BooksContext.Provider value={{ books, addBook, removeBook }}>
      {children}
    </BooksContext.Provider>
  );
}

export function useBooks() {
  const context = useContext(BooksContext);
  if (!context) {
    throw new Error('useBooks must be used within a BooksProvider');
  }
  return context;
}
```

### გამოყენება კომპონენტში:

```typescript
// კომპონენტში გამოყენება
import { useBooks } from '@/context/books/BooksContext';

function BookList() {
  const { books, addBook, removeBook } = useBooks();
  // ...
}
```

---

## 📝 დასამახსოვრებელი

| წესი | აღწერა |
|------|--------|
| 🚫 | არასოდეს შექმნა TSX პირდაპირ `components/` ფოლდერში |
| 📂 | ყოველი კომპონენტი უნდა იყოს სუბ-ფოლდერში |
| 🗂️ | მსგავსი კომპონენტები დააჯგუფე sub-sub ფოლდერებში |
| 📛 | ფოლდერის სახელები lowercase, კომპონენტები PascalCase |
| 🌐 | API/ბაზა ურთიერთობისას გამოიყენე **Axios** |
| 📁 | Axios instance უნდა იყოს `lib/axios/` ფოლდერში |
| 🔧 | API სერვისები უნდა იყოს `services/api/` ფოლდერში |
| 🔄 | მონაცემთა მიმოცვლისას გამოიყენე **Context API** |
| 📂 | Context ფაილები უნდა იყოს `context/` ფოლდერში |
| 🪝 | ყოველ Context-ს უნდა ჰქონდეს custom hook (მაგ: `useBooks`) |
| 🗄️ | მონაცემთა ბაზა: **Supabase** |
| 📁 | Supabase client უნდა იყოს `lib/supabase/` ფოლდერში |
| 🛤️ | `page.tsx`-ში მხოლოდ კომპონენტის გამოძახება - სტილების გარეშე |
| 📂 | გვერდების კომპონენტები უნდა იყოს `components/pages/` ფოლდერში |


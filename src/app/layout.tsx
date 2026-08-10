import type { Metadata } from "next";

import "./globals.css";

export const metadata: Metadata = {
  title: "CUMPAVIO",
  description: "Shopping intelligence for Moldova.",
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="ru">
      <body>{children}</body>
    </html>
  );
}
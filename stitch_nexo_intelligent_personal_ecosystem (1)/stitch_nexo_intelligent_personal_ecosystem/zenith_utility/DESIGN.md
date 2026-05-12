---
name: Zenith Utility
colors:
  surface: '#fcf8fb'
  surface-dim: '#dcd9dc'
  surface-bright: '#fcf8fb'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f3f5'
  surface-container: '#f0edef'
  surface-container-high: '#eae7ea'
  surface-container-highest: '#e4e2e4'
  on-surface: '#1b1b1d'
  on-surface-variant: '#4d4632'
  inverse-surface: '#303032'
  inverse-on-surface: '#f3f0f2'
  outline: '#7f775f'
  outline-variant: '#d0c6ab'
  surface-tint: '#705d00'
  primary: '#705d00'
  on-primary: '#ffffff'
  primary-container: '#ffd600'
  on-primary-container: '#705d00'
  inverse-primary: '#e9c400'
  secondary: '#5d5e60'
  on-secondary: '#ffffff'
  secondary-container: '#dfdfe1'
  on-secondary-container: '#616365'
  tertiary: '#5d5e63'
  on-tertiary: '#ffffff'
  tertiary-container: '#d9d8dd'
  on-tertiary-container: '#5d5e63'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffe170'
  primary-fixed-dim: '#e9c400'
  on-primary-fixed: '#221b00'
  on-primary-fixed-variant: '#544600'
  secondary-fixed: '#e2e2e4'
  secondary-fixed-dim: '#c6c6c8'
  on-secondary-fixed: '#1a1c1d'
  on-secondary-fixed-variant: '#454749'
  tertiary-fixed: '#e3e2e7'
  tertiary-fixed-dim: '#c6c6cb'
  on-tertiary-fixed: '#1a1b1f'
  on-tertiary-fixed-variant: '#46464b'
  background: '#fcf8fb'
  on-background: '#1b1b1d'
  surface-variant: '#e4e2e4'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  title-sm:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-caps:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  container-margin: 20px
  gutter: 16px
---

## Brand & Style
The design system is centered on high-efficiency minimalism, drawing inspiration from high-end productivity tools. The personality is organized, approachable, and quiet, prioritizing content clarity over visual noise. It targets users who value focus and intentionality in their digital workspace.

The aesthetic follows a **Modern Minimalist** movement with a focus on functional utility. It utilizes a "White-Plus" strategy: predominantly white environments punctuated by soft-grey architectural surfaces and a singular, high-energy accent. The goal is to evoke a sense of digital "freshness" and mental breathing room, avoiding the sterile coldness of pure tech or the cluttered density of legacy enterprise software.

## Colors
The palette is intentionally restrained to maximize the impact of the primary accent. 

- **Primary (#FFD600):** A bright, optimistic yellow used sparingly for key actions, selection states, and meaningful highlights.
- **Surface & Background:** Pure white (#FFFFFF) is the base for the main canvas. A secondary soft grey (#F5F5F7) is used to define distinct functional containers, sidebars, or "wells" for content.
- **Neutrals:** Typography utilizes a deep charcoal (#1D1D1F) rather than pure black to maintain softness. Tertiary greys are reserved for borders, placeholders, and inactive states.

## Typography
The system uses **Inter** for its exceptional legibility and neutral, systematic tone. The type scale is built on a tight ratio to maintain a compact, organized feel. 

Headlines utilize slightly tighter letter spacing and heavier weights to create a clear visual anchor on the page. Body text is optimized for long-form reading with generous line heights. Labels use a semi-bold weight to ensure functional elements are easily discoverable despite their smaller scale.

## Layout & Spacing
This design system employs a **Fixed-Fluid Hybrid** layout. On mobile, it utilizes a fluid 4-column grid with 20px margins. On desktop, content is contained within a centered 12-column grid with a maximum width of 1280px.

The spacing rhythm follows a 4px base unit, with 16px (md) being the standard padding for most cards and containers. Wide margins are used between major sections to emphasize the minimalist aesthetic and prevent the UI from feeling cramped.

## Elevation & Depth
Depth is communicated through **Tonal Layering** supplemented by **Ambient Shadows**. 

- **Level 0 (Base):** Pure white background.
- **Level 1 (Submerged):** Soft grey surfaces (#F5F5F7) used for secondary areas like sidebars or search bars.
- **Level 2 (Raised):** White cards with a subtle, highly diffused shadow (0px 4px 20px rgba(0,0,0,0.04)). This is the primary state for interactive content.
- **Level 3 (Overlay):** Floating elements like modals or menus, using a slightly more pronounced shadow (0px 8px 30px rgba(0,0,0,0.08)) to indicate priority.

Avoid heavy borders; use subtle shifts in surface color to define boundaries.

## Shapes
The shape language is defined by **Moderate Roundness**. A standard 16px radius (rounded-lg) is applied to all primary containers and cards, creating a friendly and modern feel that isn't overly organic or "bubbly." 

Small components like buttons and input fields use a consistent 8px (base) or 12px radius. This consistency in rounding helps soften the minimalist layout, making the utility-focused interface feel more approachable and less rigid.

## Components
- **Buttons:** Primary buttons feature the #FFD600 background with dark text. Secondary buttons use the soft grey surface with no border. No heavy gradients or 3D effects.
- **Cards:** White backgrounds with a 16px corner radius and Level 2 elevation. Use for individual notes or list items.
- **Input Fields:** Soft grey backgrounds with no border in their default state. On focus, the background remains, but a 2px #FFD600 border is added.
- **Chips/Tags:** Small, pill-shaped elements with light grey backgrounds and medium-weight labels. When active, they switch to the primary yellow.
- **Lists:** Clean rows with 1px light grey separators (#E5E5E5) that do not span the full width of the container, leaving a "gutter" on the left and right.
- **Checkboxes:** Rounded squares (4px radius). When checked, they fill with #FFD600 and display a dark tick icon.
- **Floating Action Button (FAB):** A circular button with #FFD600 background and a Level 3 shadow, typically used for the "New Note" action.
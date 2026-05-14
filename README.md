# Little Lemon monorepo

**Maintainer:** [Ehsan Ghafoori](https://github.com/EhsanGhafoori) · Repository: [github.com/EhsanGhafoori/lemon-app](https://github.com/EhsanGhafoori/lemon-app)

This repo has **two** apps:

| Part | Stack | How to run |
|------|--------|------------|
| **Repository root** | [Expo](https://expo.dev) + React Native (based on the [CubiFlow/lemon-app](https://github.com/CubiFlow/lemon-app) template) | `npm install` → `npx expo start` |
| **`little-lemon-food-ordering/`** | SwiftUI (Meta / Coursera iOS capstone) | Open `little-lemon-food-ordering/LittleLemonFoodOrdering.xcodeproj` in **Xcode** on a Mac (iOS 17+ simulator recommended) |

**Course / peer review:** add your **Home screen wireframe** (export from Figma as JPG) under:

`little-lemon-food-ordering/design/`  
(e.g. `HomeScreenWireframe.jpg`).

---

## Expo app (root)

Created with [`create-expo-app`](https://www.npmjs.com/package/create-expo-app). Routing lives in the [`app`](./app) directory ([Expo Router](https://docs.expo.dev/router/introduction/)).

```bash
npm install
npx expo start
```

Then choose **iOS simulator**, **Android emulator**, **Expo Go**, or a **development build** from the terminal UI.

To reset the starter to a blank `app` folder (optional):

```bash
npm run reset-project
```

**Docs:** [Expo documentation](https://docs.expo.dev/) · [Learn Expo tutorial](https://docs.expo.dev/tutorial/introduction/)

---

## Native iOS app (`little-lemon-food-ordering/`)

- **Open:** `LittleLemonFoodOrdering.xcodeproj`
- **Signing:** set your **Team** in Xcode if the simulator build fails for signing.
- **Wireframe:** commit a JPG into `design/` for assignment submission.

---

## Community (Expo)

- [Expo on GitHub](https://github.com/expo/expo)
- [Discord](https://chat.expo.dev)

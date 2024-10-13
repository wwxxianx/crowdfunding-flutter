# Flutter Crowdfunding w/ NestJS

![App Showcase](https://github.com/user-attachments/assets/edc85777-1509-4002-bad2-910a31b79d12)

This is a full-stack crowdfunding application built with Flutter and NestJS. It follows the best practices of building a scalable and enterprise-level system such as clean architecture, automated testing, etc. 

## Tech Stack

- **Client Side (Mobile)**

  ![flutter](https://github.com/user-attachments/assets/b2e4c5ef-cf92-454f-8ef0-2e56ee75a479)
  ![bloc](https://github.com/user-attachments/assets/4e27035e-5ac2-4910-8f6b-7da773c7f345)


- **Server Side**

  ![nestjs](https://github.com/user-attachments/assets/86a425d7-0195-4228-9912-8ef425e17f37)
  ![postgres](https://github.com/user-attachments/assets/af186b37-10a1-4796-a930-bbe7dc0e128a)
  ![redis](https://github.com/user-attachments/assets/0b73ef5a-052c-4252-aeae-88348eb90293)
  ![prisma](https://github.com/user-attachments/assets/234d64a0-e316-4446-882b-b154bb598866)
  ![bullmq](https://github.com/user-attachments/assets/87514453-4bed-4189-b5a4-266faa4516e3)
  ![typescript](https://github.com/user-attachments/assets/b8dc7cca-e85e-478f-a6ef-00b3e682b199)


- **Other Services**

  ![onesignal](https://github.com/user-attachments/assets/e7c29649-3be7-4f37-8898-3dc7e6000153)
  ![stripe](https://github.com/user-attachments/assets/870743c5-93c5-431c-bd8b-0cec648f03b5)
  ![supabase](https://github.com/user-attachments/assets/8953926f-7bc0-4607-a8bc-9095f3d54090)
  ![aiml](https://github.com/user-attachments/assets/045fb232-1101-4851-a061-67ac441c56ee)


- **Admin (Web)**

  ![nextjs](https://github.com/user-attachments/assets/38a50e85-b2eb-48d2-991a-832ccb1452da)
  ![tailwind](https://github.com/user-attachments/assets/dbbd313f-007d-4db4-bdbe-d1379744bafa)
  ![tanstack](https://github.com/user-attachments/assets/b6906925-1c2e-4044-9a5a-76542026b8cd)
  ![zustand](https://github.com/user-attachments/assets/ed64deef-ef27-440e-9feb-b8b91037c099)


## Screenshots & Video

- **Video Link**

- **You can also take a look on my portfolio** ![My Portfolio Site]()

- **Explore**

  ![Explore](https://github.com/user-attachments/assets/17970e00-cfc7-4aa5-a4f2-c3527b50365e)

- **Campaign Details**

  ![Campaign Details](https://github.com/user-attachments/assets/9ff54e4d-9ed3-4281-8c35-a6f1506b5285)

- **Reply Comment & Share**

  ![Reply Comment & Share](https://github.com/user-attachments/assets/e9b68196-b8c8-4113-9cc1-c765c08cb15e)

- **Donate**
  
  ![Donate](https://github.com/user-attachments/assets/412d9467-9c9f-45a7-9d56-b7c3ac218cb1)

- **Create Campaign**

  ![Create Campaign](https://github.com/user-attachments/assets/ae192761-d88e-423e-832c-549386046889)

- **Update Posts w/ AI**
- **Gift Card (Receive & Donate)**
- **Account**
- **Saved**
- **Tax Receipt**
- **Notification**
- **Own Campaign**
- **Collaboration**
- **Community Challenge**
- **Donation Challenge**


## Features

- **Auth & User Data**

  - **Email & Password Authentication:** Log in and manage user accounts with email and password credentials.

  - **Persisting Auth State and User Type Redirection:** Remain logged in and automatically land on the correct dashboard (user or admin) based on your user type, both when launching the app and while signing in.

  - **User Data Persistence with Hydrated Bloc:** Store user data persistently using Hydrated Bloc for seamless user experience.

* **Home Screen**

  - **Dynamic Home Screen Offer:** Multiple offers on the home screen, including a captivating carousel of static image banners, a curated horizontal list of deals which is also static, but the four dynamic images offers can be easily updated from the backend for a constantly refreshing experience.

* **Product Management:**

  - **Category-Wise Products:** Organize products by category for easy browsing and navigation.

  - **Product Search:** Search for products efficiently using a dedicated search feature.

  - **Product Details:** View comprehensive product details, including average rating, rating count, and product recommendations based on the product category.

  - **Product Rating System:** Rate only products you have ordered, either through product details or order details screens.

  - **Deal of the Day:** Discover the highest-rated product as the "Deal of the Day."

* **Account Features:**

  - **Order Product:** Place orders for products seamlessly.

  - **Order Details:** Check order details, including status, and receive product recommendations based on the ordered product category.

  - **Search Orders:** Easily search for specific orders.

  - **Browsing History:** Maintain a history of recently visited products for convenient access.

  - **Wishlists:** Create and manage wishlists to keep track of desired products.

- **Cart Management:**

  - **Cart List:** View and manage products added to the cart.

  - **Cart Actions:**

    - Swipe right: Delete item from cart.
    - Swipe left: Add item to Save for Later list.
    - View similar products for cart items.

  - **Save for Later List:** Manage products saved for later.

  - **Save for Later Actions:**

    - Swipe right: Delete item from Save for Later list.
    - Swipe left: Add item to cart.
    - Delete, compare, and move products between cart and save for later list.

  - **Product Recommendations:** Receive product recommendations based on user browsing history or random recommendations if no browsing history exists.

  - **Checkout Options:**

    - **Google Pay Checkout:** Checkout using Google Pay for a secure and convenient payment experience.

    - **Buy Now Checkout:** Order selected products immediately after payment using the "Buy Now" option.

- **Admin Panel:** Manage the e-commerce platform effectively with the comprehensive admin panel.

  - **Admin Panel Features:**

    - **Product Management:** View, add, and delete products category-wise.

    - **Earnings Analysis:** Track total earnings and category-based earnings using a visual graph.

    - **Four Image Offer Management:** View, add, and delete four image offers from the admin section.

    - **Order Management:** View order details and change order status.

- **Sign Out:** Easily sign out of both user and admin accounts.

- **Some of used packages:**

  - **bloc:** Leverages bloc for effective state management.

  - **hydrated_bloc:** Persists user data using hydrated_bloc for a seamless user experience.

  - **equatable:** Compares objects efficiently using equatable for enhanced performance.

  - **syncfusion_flutter_charts package:** Utilizes the syncfusion_flutter_charts package to display category-wise earnings in a comprehensive graph format.

  - **go_router:** Employs go_router for efficient page navigation throughout the application.

## Run Locally

- Clone this repository

  ```bash
  https://github.com/tejasbadone/flutterzon_bloc.git
  ```

- Migrate to the root directory and install all the required dependencies by running
  ```bash
  flutter pub get
  ```
- Create MongoDB Project & Cluster
- Connect to the cluster using Drivers and get the connection string.
- I've created a `config.env` file at the root directory of the project, containing the essential details for the setup, you could also create one or update the necessary values directly, it's totally up to you. demo of `config.env` file -
    ```
    PORT=PORTHERE
    DB_USERNAME='usernameHere'
    DB_PASSWORD='passwordHere'

    URI='uriHere'

    CLOUDINARY_CLOUDNAME='cloudname'
    CLOUDINARY_UPLOADPRESET='uploadpreset'
    ```

- Head to `server/index.js` and replace the userName, password, and connection string.
- Head to `lib/src/utils/constants/strings.dart` and replace the `uri` with your IP address.
- Create Cloudinary Project, and enable the unsigned operation in settings.
- Head to `lib/src/data/repositories/admin_repository.dart`, update the `cloudinaryCloudName` and `cloudinaryUploadPreset` present in the `uploadImages()` method.
- Now, run the following commands, to migrate to the server folder, install the necessary dependencies, and run the server locally.
  ```
  cd server
  npm install
  npm run dev (to run index.js using nodemon)
  OR
  npm start (to run index.js)
  ```
  Please star⭐ the repo if you like what you see😉.

## Download

Download apk - https://drive.google.com/file/d/1K1k8DbwHfyAnujwRAPgzXmcEUVABFB_p/view?usp=sharing

## Test Credentials

- User

  - Email: user@email.com
  - Password: 123456

- Admin
  - Email: admin@email.com
  - Password: 123456

## Note

- If you wish to place an order in the application, you can enroll in the [Google Pay API Test Cards Allowlist](https://groups.google.com/g/googlepay-test-mode-stub-data). This will provide you with mock card details, allowing you to safely test the order placement functionality within a controlled environment.

- For the GitHub version of Flutterzon apk provided above, please note that certain administrative features, such as the ability to delete products and offers, have been intentionally disabled to prevent unintended tampering with the actual database. The original codebase, accessible to you, includes the complete functionality, including the ability to delete products. If you wish to explore the full range of features, please refer to the original code provided.

- Please be aware that the application or APIs might experience delays in providing details, as the server is hosted on a hobby plan, If there is no activity for 15 minutes, the server may go to sleep, resulting in a delay in processing the first API request. Your patience during this process is greatly appreciated.

- If you are interested, there is another version of this project built using Provider and Flutter's `setState`. You can access it [here](https://github.com/tejasbadone/flutterzon_provider).

## Disclaimer

This application is a personal project built with educational and learning purposes in mind. It is neither affiliated nor endorsed by Amazon in any way. While the app features product details and images inspired by Amazon, these are solely for demonstration purposes and may not represent actual products. All rights to these elements belong to their respective owners. We are using them for educational purposes only and have no intention of commercial exploitation.

Additionally, be aware that any attempts to place orders within this prototype are purely for testing purposes and will not result in actual product deliveries or charges in the real-world. This environment is designated exclusively for simulation and development purposes

## Contact

- Tejas Badone <br> <br>
  <a  href="https://www.linkedin.com/in/tejasbadone/" target="_blank"><img alt="LinkedIn" src="https://img.shields.io/badge/linkedin%20-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white" /></a>
  <a href="mailto:tejas.badone25@gmail.com"><img  alt="Gmail" src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white" />

  feel free to contact me!

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/tejasbadone/flutterzon_bloc/blob/main/LICENSE) file for details

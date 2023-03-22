<h1>TestOnlineShop</h1>

Это приложение – онлайн магазин, является тестовым заданием на позицию iOS-разработчик.
This application is an online store, it is a test task for the position of iOS developer.

<img src="https://user-images.githubusercontent.com/91027381/226894398-c38be833-5ed4-4549-8e8b-b59c307d165e.gif" alt="preview" width="200" align="left"/>

[Video about app works / Видео о работе приложения](https://youtu.be/cEdbvGy9JQ0)  

<h2>Overview / Обзор</h2>

В тестовом задании нужно было реализовать простое приложение для iPhone.
Приложение должно регистрировать пользователя, обеспечить возможность работы с данными пользователя и отображать данные товаров магазина в кастомном интерфейсе. 
Пользователь должен иметь возможность просматривать подробную информацию о выбранном товаре.



<h2>UI Description / Описание</h2>
<p>
  • Разработанное приложение имеет экраны регистрации, авторизации, профиля, главный экран магазина, на котором имеются несколько секций-категорий, в которых расположены кастомные ячейки, и детальный экран.
  
  • Приложение подключается к серверу, принимает данные в формате JSON, и распределяет на интерфейс.
  
  • Имеется строка поиска, которая также отправляет запросы на сервер, и получает ответ спустя 1 секунду.
  
  • Экран авторизации определяет не был ли зарегистрирован ранее пользователь, и соответствует ли email соответствующей форме, сохраняет пользователя по его имени в памяти телефона.
  
  • Экран логина, определяет правильность введенных данных, есть функция ввода скрытого пароля.
  
  • На главном экране магазина секции обновляются одномоментно. Каждую секцию можно скроллить. При нажатии на секцию перейти к детальному рассомтрению товара.
  
  • На экране детализации – расположено несколько секций, секции с фотографиями взаимосвязаны: при скролле большой фотографии – переключается малая, и наоборот. Также пользователь может выбрать цвет товара, прочитать его описание, добавить в избранное, поделиться, отсчитать нужное количество и перейти на экран корзины.
  
  • Приложение имеет кастомный TabBar с пятью элементами.
  
  • Экран профиля содержит информацию о пользователе и его фотографию. При нажатии на кнопку "Изменить фото" пользователь получает возможность выбрать фотографию из галереи, либо сделать фотографию на камеру. Данное изображение можно отредактировать, выбрать и сохранить в памяти телефона. 
  
  • Данные пользователя сохраняются в памяти даже после перезапуска приложения.
  
  • Сохраненное изображение пользователя отображается также на главное экране приложения.
  
  • Во вкладке профиль, нажав на кнопку "Выйти" осуществляется переход на экран регистрации.
  
  • В приложение реализована EN-RU локализация.
  
  • Приложение разработано в соответствии с макетом Figma
  
  
  
  • The developed application has registration, authorization, profile screens, the main screen of the store, on which there are several sections-categories in which custom cells are located, and a detailed screen.
  
  • The application connects to the server, accepts data in JSON format, and distributes it to the interface.
  
  • There is a search string that also sends requests to the server, and receives a response after 1 second.
  
  • The authorization screen determines whether the user has not been registered before, and whether the email corresponds to the appropriate form, saves the user by his name in the phone memory.
  
  • Login screen, determines the correctness of the entered data, there is a function for entering a hidden password.
  
  • Sections are updated simultaneously on the main screen of the store. Each section can be scrolled. When you click on the section, go to the detailed description of the product.
  
  • On the detail screen – there are several sections, sections with photos are interconnected: when scrolling a large photo, a small one switches, and vice versa. The user can also choose the color of the product, read its description, add to favorites, share, count the required amount and go to the shopping cart screen.
  
  • The application has a custom TabBar with five elements.
  
  • The profile screen contains information about the user and his photo. By clicking on the "Edit photo" button, the user gets the opportunity to select a photo from the gallery, or take a photo on the camera. This image can be edited, selected and saved in the phone's memory.
  
  • User data is stored in memory even after restarting the application.
  
  • The saved image of the user is also displayed on the main screen of the application.
  
  • In the profile tab, clicking on the "Log Out" button takes you to the registration screen.
  
  • EN-RU localization is implemented in the application
  
  • The application is designed according to the Figma layout
  
</p>

<h2>Other / Другое</h2>
<p>
  • Разработано на `UIKit` с применением `Combine`, `MVVM+C`
  
  • Работа с `API`
  
  • Верстка кодом
  
  • Developed on `UIKit` using `Combine`, `MVVM+C`
  
  • Code autolayout
  
  • Work with `API`
</p>

## Contact Info / Контакты
* [Telegram](https://t.me/kostya_grachev) 

iosgracheff@gmail.com

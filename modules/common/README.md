# Common

### A library that accumulates all common classes, interactors, managers

#### Схема взаимодействия с другими плагинами если меняем этот плагин:
1. Поднимаем номер [тега](https://gitlab.contentdatapro.com/mobile/portal-mobile/common/-/tags) в текущей библиотеке [common](https://gitlab.contentdatapro.com/mobile/portal-mobile/common) <br/>
2. В библиотеке [service](https://gitlab.contentdatapro.com/mobile/portal-mobile/service) поднимаем номер тега текущей библиотеки [common](https://gitlab.contentdatapro.com/mobile/portal-mobile/common) и далее поднимаем номер тега внутри самой [service](https://gitlab.contentdatapro.com/mobile/portal-mobile/service)<br/>
3. В библиотеке [api_client](https://gitlab.contentdatapro.com/mobile/portal-mobile/api_client) поднимаем номера тегов библиотек [common](https://gitlab.contentdatapro.com/mobile/portal-mobile/common), [service](https://gitlab.contentdatapro.com/mobile/portal-mobile/service) и после поднятия всех этих тегов поднимаем номер тега самой библиотеки [api_client](https://gitlab.contentdatapro.com/mobile/portal-mobile/api_client).<br/>
4. В проекте [portal_app_flutter](https://gitlab.contentdatapro.com/mobile/portal-mobile/portal-app-flutter) поднимаем номера тегов всех выше указанных библиотек
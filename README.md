# zurl

> Это моя первая программа, написанная на Zig. Осторожно, нейро-слоп!

Маленькая программка, для проверки статуса сайта по URL.

## Что делает?

Отправляет GET-запрос на переданный URL, выдаёт HTTP статус ответа (`200`, `400` и т.п)

## Требования

`Zig v0.16.0`

![icon](https://skills.syvixor.com/api/icons?i=zig)

## Билд

```bash
git clone https://github.com/j0u1/zurl.git
cd zurl
zig build
```

Готовый бинарник появится в `zig-out/bin/zurl`

## Установка глобально (опционально)

```bash
sudo cp zig-out/bin/zurl /usr/local/bin/
```

После этого `zurl` можно вызывать из любой директории.

## Использование

```bash
zurl <url>
```

Пример:

```bash
zurl https://example.com
# Status: ok (200)
```

Если сайт недоступен или домен не резолвится - вместо краша программа выведет понятную ошибку:

```bash
zurl https://несуществующий-домен.ru
# Failed to get status: UnknownHostName
```

P.S. Буду рад увидеть `PR`!

## Лицензия

MIT

# Arduino Manager GUI (Go)
**БЕТА ТЕСТИРОВАНИЕ. СКАЧИВАТЬ НА СВОЙ СТРАХ И РИСК**

Оконная версия исходного bash-скрипта Arduino Manager.

## Что перенесено

- Поиск Arduino-библиотек и board cores через GitHub API.
- Фильтры GitHub: creator, minimum stars, sort, order, limit.
- Установка/обновление библиотек из GitHub, включая конкретный git tag.
- Получение и установка версий библиотек из официального `library_index.json`.
- Импорт/обновление локального индекса.
- Список установленных библиотек с определением `library.properties`.
- Поиск и список установленных board cores.
- Установка популярных board cores.
- Автоопределение `vendor/arch` для известных репозиториев.
- Запуск `tools/get.py`, `tools/install.sh` или `post_install.sh` для board setup.
- Удаление через файловую систему можно делать безопасно через те же директории, но отдельные кнопки удаления в GUI намеренно не добавлены в первый вариант.
- Настройка `SKETCHBOOK` и `ARDUINO_DATA` с записью в `~/.arduino-manager.conf`.

## Сборка

Требуется Go 1.22+ и зависимости Fyne 2.8.0. Fyne использует системные графические зависимости, поэтому сборку нужно выполнять на целевой ОС.

```bash
go mod tidy
go build -o arduino-manager-gui .
./arduino-manager-gui
```

На Linux перед сборкой должен быть установлен C-компилятор и dev-зависимости графического стека, необходимые Fyne.

## Архитектура

Сетевые запросы и `git`/setup-операции выполняются в goroutine, чтобы окно не зависало. Вывод процессов попадает в нижний журнал.

Исходный bash-скрипт остается независимым и не запускается из GUI: основные операции реализованы нативно на Go.


## GUI refresh

The current build uses a desktop-oriented layout: left navigation, a dedicated search card, richer result rows, an inline details/actions pane, and a compact activity log. The Fyne UI uses its standard dark theme and theme icons so it remains readable on Linux desktops.

## Keyboard shortcuts

- Enter in the search field: run search
- Ctrl+F / Ctrl+L: focus the search field
- Ctrl+K: clear the search field
- Ctrl+1 / Ctrl+2 / Ctrl+3: Libraries / Boards / Local index
- Ctrl+R: repeat the current search
- Esc: cancel the active network/git operation

While an operation is running, a Cancel button appears in the header. Network requests use the active operation context and git commands are started with `exec.CommandContext`, so cancellation can interrupt them.

Long repository names and descriptions in the results list are truncated with ellipsis so they stay inside the results pane.
    
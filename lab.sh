#!/usr/bin/env bash
# Лабораторна: дерево каталогів, файли, копіювання, перевірка email, пошук 404
set -euo pipefail
cd "$(dirname "$0")"
source ./config.env

ROOT="$SURNAME"

# 9. Дерево: AAA -> DEE, SEE, SSS
mkdir -p "$ROOT/DEE" "$ROOT/SEE" "$ROOT/SSS"
echo "$EMAIL" > "$ROOT/DEE/${FIRSTNAME}.txt"
printf "Група: %s\nДата: %s\n" "$GROUP" "$DATE" > "$ROOT/SSS/${SURNAME}.txt"

# 10. Копіювання файлів у кореневий каталог (AAA)
cp "$ROOT/DEE/${FIRSTNAME}.txt" "$ROOT/"
cp "$ROOT/SSS/${SURNAME}.txt" "$ROOT/"

# 11. Перевірка email регулярним виразом
EMAIL_REGEX='^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
if grep -Eq "$EMAIL_REGEX" "$ROOT/${FIRSTNAME}.txt"; then
  echo "Email коректний: $EMAIL"
else
  echo "Email некоректний!"
  exit 1
fi

# 13. Помилки 404 в Apache-логах
COUNT_404=$(grep -Ec 'HTTP/[0-9.]+" 404 ' "$LOGFILE" || true)
echo "Кількість 404: $COUNT_404"
grep -E 'HTTP/[0-9.]+" 404 ' "$LOGFILE" || true

Вам дан набор данных, представляющих геопозиции курьера, собранные с GPS- маячка, установленного на его электровелосипеде. Маячок собирает данные каждые 20 секунд. Из-за
плотной застройки и различных помех данные могут быть неточными, с погрешностью до 50 метров, особенно в местах парковки.
Предложите алгоритм для обработки данных геопозиций курьера с целью построения его маршрута на карте. Алгоритм должен минимизировать резкие скачки в данных и
максимально точно отражать реальный маршрут курьера.

# Алгоритм

Желательно это делать в numpy

Для каждой точки:

 - получить точку
 - проверить резкий скачок (фильтр Калмана). Если точка перемещается слишком быстро (больше 40 км/ч), то проигнорировать ее, заменить на среднее значение.
 - проверить остановку. Если координаты почти не меняются, проигнорировать.
 - при отсутствии точек в продолжительное время - добавить лишние между последней видимой точкой и текущей

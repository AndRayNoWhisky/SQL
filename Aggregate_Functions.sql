/*Напишите запрос, который выведет:
количество покемонов (столбец pokemon_count),
среднюю скорость (столбец avg_speed),
максимальное и минимальное число очков здоровья (столбцы max_hp и min_hp) для электрических (Electric) покемонов, 
имеющих дополнительный тип и показатели атаки или защиты больше 50.*/
SELECT
    COUNT(id) AS pokemon_count,
    AVG(speed) AS avg_speed,
    max(hp) as max_hp,
    min(hp) as min_hp
FROM sql.pokemon
WHERE type1 = 'Electric'
and type2 is not null
and (attack > 50 or defense>50)

/*Напишите запрос, который выведет:
число различных дополнительных типов (столбец additional_types_count),
среднее число очков здоровья (столбец avg_hp),
сумму показателей атаки (столбец attack_sum) в разбивке по основным типам (столбец primary_type).
Отсортируйте результат по числу дополнительных типов в порядке убывания, при равенстве — по основному типу в алфавитном порядке.
Столбцы к выводу (обратите внимание на порядок!): primary_type, additional_types_count, avg_hp, attack_sum.*/
SELECT
    type1 AS primary_type,
    COUNT(distinct type2) AS additional_types_count,
    avg(hp) as avg_hp,
    sum(attack) as attack_sum
FROM sql.pokemon
GROUP BY primary_type
ORDER BY additional_types_count DESC, primary_type

/*Напишите запрос, который выведет основной и дополнительный типы покемонов 
(столбцы primary_type и additional_type) для тех, у кого средний показатель атаки больше 100 
и максимальный показатель очков здоровья меньше 80.*/
SELECT
    type1 AS primary_type,
    type2 AS additional_type
FROM sql.pokemon
GROUP BY primary_type, additional_type 
HAVING AVG(attack) > 100 and max(hp) < 80

/*Напишите запрос, чтобы для покемонов, чьё имя (name) начинается с S, 
вывести столбцы с их основным типом (primary_type) и общим числом покемонов этого типа (pokemon_count).
Оставьте только те типы, у которых средний показатель защиты больше 80.
Выведите топ-3 типов по числу покемонов в них.*/
SELECT
    type1 AS primary_type,
    count(*) as pokemon_count
FROM sql.pokemon
where name like 'S%'
GROUP BY primary_type 
having avg(defense)>80
order by pokemon_count DESC
limit 3

/*Напишите запрос, который выведет основной и дополнительный типы покемонов 
и средние значения по каждому показателю (столбцы avg_hp, avg_attack, avg_defense, avg_speed).
Оставьте только те пары типов, у которых сумма этих четырёх показателей более 400.*/
SELECT
    type1 as primary_type,
    type2 as additional_type,
    avg(hp) as avg_hp,
    avg(attack) as avg_attack,
    avg(defense) as avg_defense,
    avg(speed) as avg_speed
FROM sql.pokemon
GROUP BY primary_type, additional_type 
having (avg(hp) + avg(attack) + avg(defense) + avg(speed)) >400

/*Напишите запрос, который выведет столбцы с основным типом покемона и общим количеством покемонов этого типа.
Учитывайте только тех покемонов, у кого или показатель атаки, или показатель защиты принимает значение между 50 и 100 включительно.
Оставьте только те типы покемонов, у которых максимальный показатель здоровья не больше 125.
Выведите только тот тип, который находится на пятом месте по количеству покемонов.*/
SELECT
    type1,
    count(*) as pokemon_count
FROM sql.pokemon
where
    attack between 50 and 100
    or defense between 50 and 100
GROUP BY type1
having max(hp) <=125
order by pokemon_count DESC
offset 4 limit 1
/*Напишите запрос, который выведет сезон (season), 
а также общее количество забитых мячей домашними (total_home_goals) 
и гостевыми (total_away_goals) командами.
Отсортируйте по столбцу с сезоном в порядке возрастания.*/
SELECT
    season,
    sum(home_team_goals) as home_team_goals,
    sum(away_team_goals) as away_team_goals
FROM sql.matches
group by season
order by season

/*Напишите запрос, который выведет два столбца: 
id матча (match_id) и id домашней команды (team_id).
Отсортируйте по id матча в порядке возрастания значений.*/
SELECT
    matches.id match_id,
    teams.id team_id
FROM
    sql.teams
    join sql.matches on home_team_api_id = api_id
order by match_id

/*Напишите запрос, который выведет столбцы:
id матча,
короткое название домашней команды (home_short),
короткое название гостевой команды (away_short).
Отсортируйте запрос по возрастанию id матча.*/
SELECT
    m.id match_id,
    h.short_name home_short,
    a.short_name away_short
FROM
    sql.matches m
    JOIN sql.teams h ON m.home_team_api_id = h.api_id
    JOIN sql.teams a ON m.away_team_api_id = a.api_id
order by match_id

/*Напишите запрос, который выведет полное название команды (long_name), 
количество голов домашней команды (home_goal) 
и количество голов гостевой команды (away_goal) 
в матчах, где домашней командой были команды с коротким названием 'GEN'.
Отсортируйте запрос по id матча в порядке возрастания.*/
SELECT
    t.long_name,
    m.home_team_goals,
    m.away_team_goals
FROM
    sql.teams t
    JOIN sql.matches m ON m.home_team_api_id = t.api_id
WHERE short_name = 'GEN'
order by m.id

/*Напишите запрос, чтобы вывести id матчей, 
короткое название домашней команды (home_short), 
короткое название гостевой команды (away_short) 
для матчей сезона 2011/2012, в которых участвовала команда с названием Liverpool.
Отсортируйте по id матча в порядке возрастания.*/
SELECT
    m.id,
    h.short_name home_short,
    a.short_name away_short
FROM
    sql.matches m
    JOIN sql.teams h ON m.home_team_api_id = h.api_id
    JOIN sql.teams a ON m.away_team_api_id = a.api_id
WHERE
    season ='2011/2012'
    and (h.long_name = 'Liverpool' or a.long_name='Liverpool')
order by m.id

/*Напишите запрос, с помощью которого можно вывести список полных названий команд, 
сыгравших в гостях 150 и более матчей.
Отсортируйте список по названию команды.*/
SELECT
    t.long_name
    FROM sql.matches m
JOIN sql.teams t ON t.api_id = m.away_team_api_id
GROUP BY t.id
HAVING count(m.away_team_goals) >= 150
order by 1

/*Используя LEFT JOIN, выведите список уникальных названий команд, 
содержащихся в таблице matches. Отсортируйте список в алфавитном порядке.
В поле ниже введите запрос, с помощью которого вы решили задание.*/
SELECT
    t.long_name
FROM sql.matches m
LEFT JOIN sql.teams t ON t.api_id = m.home_team_api_id OR t.api_id = m.away_team_api_id
where m.id is not null
group by t.long_name
order by t.long_name

/*Используя LEFT JOIN, напишите запрос, который выведет 
полное название команды (long_name), 
количество матчей, в которых участвовала команда, — домашних и гостевых (matches_cnt).
Отсортируйте по количеству матчей в порядке возрастания.*/
SELECT
    t.long_name,
    count(m.id) matches_cnt
FROM
    sql.teams t
LEFT JOIN sql.matches m ON t.api_id = m.home_team_api_id OR t.api_id = m.away_team_api_id
group by t.id
order by matches_cnt

/*Напишите запрос, который выведет все возможные уникальные комбинации 
коротких названий домашней команды (home_team) 
и коротких названий гостевой команды (away_team).
Отсортируйте запрос по первому и второму столбцам.*/
SELECT
    DISTINCT
    t1.short_name home_team,
    t2.short_name away_team
FROM
    sql.teams t1
    CROSS JOIN sql.teams t2
order by 1, 2

/*Напишите запрос, который выведет список уникальных полных названий команд (long_name), 
игравших в гостях в матчах сезона 2012/2013.
Отсортируйте список в алфавитном порядке.*/
SELECT
    distinct
    t.long_name long_name
FROM
    sql.teams t
    JOIN sql.matches m ON m.away_team_api_id = t.api_id
WHERE
    season ='2012/2013'
order by 1

/*Напишите запрос, который выведет полное название команды (long_name) 
и общее количество матчей (matches_cnt), сыгранных командой Inter в домашних матчах.*/
SELECT
    t.long_name long_name,
    count(m.id) matches_cnt
FROM
    sql.teams t
    JOIN sql.matches m ON m.home_team_api_id = t.api_id
WHERE
    long_name = 'Inter'
group by 1

/*Напишите запрос, который выведет топ-10 команд (long_name) по количеству забитых голов 
в гостевых матчах. Во втором столбце запроса выведите суммарное количество голов 
в гостевых матчах (total_goals).*/
SELECT
    t.long_name long_name,
    sum(m.away_team_goals) total_goals
FROM
    sql.teams t
    JOIN sql.matches m ON m.away_team_api_id = t.api_id
group by 1
order by total_goals DESC
limit 10

/*Выведите количество матчей между командами Real Madrid CF и FC Barcelona.
В поле ниже введите запрос, с помощью которого вы решили задание.*/
SELECT
    count(m.id)
FROM
    sql.matches m
    JOIN sql.teams h ON m.home_team_api_id = h.api_id
    JOIN sql.teams a ON m.away_team_api_id = a.api_id
WHERE
    h.long_name in ('Real Madrid CF', 'FC Barcelona') and a.long_name in ('Real Madrid CF', 'FC Barcelona')

/*Напишите запрос, который выведет название команды (long_name), 
сезон (season) и суммарное количество забитых голов в домашних матчах (total_goals).
Оставьте только те строки, в которых суммарное количество голов менее десяти.
Отсортируйте запрос по названию команды, а затем — по сезону.*/
SELECT
    t.long_name,
    m.season,
    sum(m.home_team_goals) as total_goals
FROM
    sql.teams t
    JOIN sql.matches m ON m.home_team_api_id = t.api_id
group by 1, 2
having sum(m.home_team_goals) < 10
order by 1, 2


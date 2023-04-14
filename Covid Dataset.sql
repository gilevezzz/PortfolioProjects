SELECT *
FROM coviddeaths
ORDER BY 3,4

SELECT *
FROM covidvax
ORDER BY 3,4

--Knowing the date range of the dataset

SELECT MIN(date) AS initial_date, MAX(date) AS last_date
FROM coviddeaths

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM coviddeaths
ORDER BY 1, 2

---Total Cases Vs Total Deaths, Death Percentage

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS int)) AS total_deaths, SUM(CAST(new_deaths AS int))/SUM(New_Cases)*100 AS DeathPercentage
FROM coviddeaths
WHERE continent IS NOT null 
ORDER BY 1,2

--------------------------------------------------------------------------------------------------------------------------------------------------------------

---Total Death Count per Location, Death Comparison in terms of Income

SELECT location, SUM(CAST(new_deaths AS int)) AS TotalDeathCount
FROM coviddeaths
WHERE continent IS null 
and location not in ('World', 'European Union', 'International')
GROUP BY location
ORDER BY TotalDeathCount DESC
--------------------------------------------------------------------------------------------------------------------------------------------------------------

---Covid Cases as Percentage of the Population

SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount,  Max((total_cases/population))*100 AS PercentPopulationInfected
FROM coviddeaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC
--------------------------------------------------------------------------------------------------------------------------------------------------------------


---Total Cases per Country, and Percentage of the Population Infected

SELECT Location, Population,date, MAX(total_cASes) AS HighestInfectionCount,  Max((total_cases/population))*100 AS PercentPopulationInfected
FROM coviddeaths
GROUP BY Location, Population, date
ORDER BY PercentPopulationInfected DESC
----------------------------------------------------------------------------------------------------------------------------------------------------------

---Timeline

SELECT cd.date, cd.continent, cd.location, cd.total_deaths, cv.total_vaccinations
FROM coviddeaths cd
JOIN covidvax cv 
ON cd.location = cv.location
----------------------------------------------------------------------------------------------------------------------------------------------------

--Countries with highest deaths

SELECT location, MAX(total_deaths) AS totaldeathcount
FROM coviddeaths
GROUP BY location
ORDER BY 2 DESC

--Highest deaths by Continent

SELECT continent, MAX(total_deaths) AS totaldeathcount
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY totaldeathcount DESC

--
--Global Numbers

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, (SUM(new_cases)/SUM(new_deaths))*100 AS deathpercentage
FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2

--Total population vs. Total vaccination

SELECT dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations, SUM(CAST(vax.new_vaccinations AS int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS cumulative_vaccinated
FROM PortfolioProject01..coviddeaths dea
JOIN PortfolioProject01..covidvax vax
	ON dea.location = vax.location
	AND dea.date = vax.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

--CTE

WITH vax_vs_pop (continent, lcoation, date, population, new_vaccinations, cumulative_vaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations, SUM(CAST(vax.new_vaccinations AS int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS cumulative_vaccinated
FROM PortfolioProject01..coviddeaths dea
JOIN PortfolioProject01..covidvax vax
	ON dea.location = vax.location
	AND dea.date = vax.date
WHERE dea.continent IS NOT NULL
)
SELECT *, (cumulative_vaccinated/population)*100 cumulative_vaccinated_percentage
FROM vax_vs_pop







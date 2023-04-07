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

--Looking at total cases vs total deaths 

SELECT location, date, total_cases, total_deaths, (CAST(total_deaths AS int)/total_cases)*100 AS deathpercentage
FROM coviddeaths
ORDER BY 1, 2

--Total cases vs Population

SELECT location, date, total_cases, population, (total_cases/population)*100 AS infectionrate
FROM coviddeaths
ORDER BY 1, 2

--Countries with highest infection rate

SELECT location, date, total_cases, population, (total_cases/population)*100 AS infectionrate
FROM coviddeaths
ORDER BY 5 DESC

--Countries with highest deaths

SELECT location, MAX(total_deaths) AS totaldeathcount
FROM coviddeaths
GROUP BY location
ORDER BY totaldeathcount DESC

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







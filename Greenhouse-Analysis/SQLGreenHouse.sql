use proyectssql;

Select * from cleaned_ghg_emissions;

-- Total emision per year
Select 
	sum(F2010) as Total_F2010, sum(F2011) as Total_F2011, sum(F2012) as Total_F2012, 
    sum(F2013) as Total_F2013, sum(F2014) as Total_F2014,sum(F2015) as Total_F2015, 
    sum(F2016) as Total_F2016, sum(F2017) as Total_F2017, sum(F2018) as Total_F2018, 
    sum(F2019) as Total_F2019, sum(F2020) as Total_F2020, sum(F2021) as Total_F2021, sum(F2022) as Total_F2022
    from cleaned_ghg_emissions;
    
-- Top emiting countries
Select country, 
Sum(F2010+F2011+F2012+F2013+F2014+F2015+F2016+F2017+F2018+F2019+F2020+F2021+F2022) as Total_emission
from cleaned_ghg_emissions
group by country
order by Total_emission DESC;

-- Emission by industry and gas type

Select industry, Gas_Type,
Sum(F2010+F2011+F2012+F2013+F2014+F2015+F2016+F2017+F2018+F2019+F2020+F2021+F2022) as Total_emission
from cleaned_ghg_emissions
group by industry, Gas_Type
order by Total_emission DESC;

-- Emissions from specific industry have change over the years

Select industry,
	sum(F2010) as Total_F2010, sum(F2011) as Total_F2011, sum(F2012) as Total_F2012, 
    sum(F2013) as Total_F2013, sum(F2014) as Total_F2014,sum(F2015) as Total_F2015, 
    sum(F2016) as Total_F2016, sum(F2017) as Total_F2017, sum(F2018) as Total_F2018, 
    sum(F2019) as Total_F2019, sum(F2020) as Total_F2020, sum(F2021) as Total_F2021, sum(F2022) as Total_F2022,
    sum(F2010)+sum(F2011)+sum(F2012)+sum(F2013)+sum(F2014)+sum(F2015)+sum(F2016)+
    sum(F2017)+sum(F2018)+sum(F2019)+sum(F2020)+sum(F2021)+sum(F2022) as Total_Emissions
    from cleaned_ghg_emissions
    group by industry
    order by industry;
    
-- Emision growth between years from specific industry have change iver the years.

Select industry,
	(sum(F2011)-sum(F2010)) / sum(F2010) * 100 as Growth_2011, 
    (sum(F2012)-sum(F2011)) / sum(F2011) * 100 as Growth_2012,
    (sum(F2013)-sum(F2012)) / sum(F2012) * 100 as Growth_2013,
    (sum(F2014)-sum(F2013)) / sum(F2013) * 100 as Growth_2014, 
    (sum(F2015)-sum(F2014)) / sum(F2014) * 100 as Growth_2015,
    (sum(F2016)-sum(F2015)) / sum(F2015) * 100 as Growth_2016,
    (sum(F2017)-sum(F2016)) / sum(F2016) * 100 as Growth_2017, 
    (sum(F2018)-sum(F2017)) / sum(F2017) * 100 as Growth_2018,
    (sum(F2019)-sum(F2018)) / sum(F2018) * 100 as Growth_2019,
    (sum(F2020)-sum(F2019)) / sum(F2019) * 100 as Growth_2020,
    (sum(F2021)-sum(F2020)) / sum(F2020) * 100 as Growth_2021,
    (sum(F2022)-sum(F2021)) / sum(F2021) * 100 as Growth_2022
    from cleaned_ghg_emissions
    group by industry
    order by industry;
    
--  AVG emission by year

Select industry,
	avg(F2010) as Avg_emissions_2010, avg(F2011) as Avg_emissions_2011, avg(F2012) as Avg_emissions_2012, 
    avg(F2013) as Avg_emissions_2013, avg(F2014) as Avg_emissions_2014,avg(F2015) as Avg_emissions_2015, 
    avg(F2016) as Avg_emissions_2016, avg(F2017) as Avg_emissions_2017, avg(F2018) as Avg_emissions_2018, 
    avg(F2019) as Avg_emissions_2019, avg(F2020) as Avg_emissions_2020, avg(F2021) as Avg_emissions_2021,
    avg(F2022) as Avg_emissions_2022,
    avg(F2010) + avg(F2011) + avg(F2012) + avg(F2013) + avg(F2014) + avg(F2015) + avg(F2016) + avg(F2017) + avg(F2018) + avg(F2019) + avg(F2020) + avg(F2021) + avg(F2022) as Total_Avg_Emissions
    from cleaned_ghg_emissions
    group by industry
    order by industry;

--  max/min emission by year
Select industry,
	max(F2010) as max_emissions_2010, min(F2010) as min_emissions_2010, 
    max(F2011) as max_emissions_2011, min(F2011) as min_emissions_2011,
    max(F2012) as max_emissions_2012, min(F2012) as min_emissions_2012,
    max(F2013) as max_emissions_2013, min(F2013) as min_emissions_2013,
    max(F2014) as max_emissions_2014, min(F2014) as min_emissions_2014,
    max(F2015) as Avg_emissions_2015, min(F2015) as min_emissions_2015,
    max(F2016) as max_emissions_2016, min(F2016) as min_emissions_2016,
    max(F2017) as max_emissions_2017, min(F2017) as min_emissions_2017,
    max(F2018) as max_emissions_2018, min(F2018) as min_emissions_2018,
    max(F2019) as max_emissions_2019, min(F2019) as min_emissions_2019,
    max(F2020) as max_emissions_2020, min(F2020) as min_emissions_2020,
    max(F2021) as max_emissions_2021, min(F2021) as min_emissions_2021,
    max(F2022) as max_emissions_2022, min(F2022) as min_emissions_2022
    from cleaned_ghg_emissions
    group by industry
    order by industry;

ALTER TABLE crowdfunding_projects_1
RENAME COLUMN id TO project_id;

ALTER TABLE crowdfunding_projects_1
RENAME COLUMN name TO project_name;

ALTER TABLE crowdfunding_creator
RENAME COLUMN name TO creator_name;

ALTER TABLE crowdfunding_location
RENAME COLUMN name TO location_name;

CREATE TABLE DIM_CATEORY AS
SELECT * FROM crowdfunding_category
LEFT JOIN crowdfunding_projects_1 ON crowdfunding_projects_1.project_id=crowdfunding_category.parent_id;

CREATE VIEW project_analysis AS
SELECT
  crowdfunding_projects_1.project_id,
  crowdfunding_projects_1.project_name,
  crowdfunding_projects_1.state AS project_state,
  crowdfunding_projects_1.country AS project_country,
 
  -- Category info
  crowdfunding_category.name,
  crowdfunding_category.id,
 
  -- Location info
  crowdfunding_location.location_name,
  crowdfunding_location.displayable_name AS location_display,
  crowdfunding_location.state AS location_state,
  crowdfunding_location.country AS location_country,
 
  -- Dates (from Calendar)
  # calendar_table.year AS created_year,
   #calendar_table.quarter AS created_quarter,
   #calendar_table.month_no AS created_month_no,
   #calendar_table.month_full_name AS created_month_name,
   #calendar_table.year_month AS created_year_month,
   #calendar_table.financial_month_no AS created_financial_month,
   #calendar_table.financial_quarter AS created_financial_quarter,
 
  -- Metrics
    crowdfunding_projects_1.goal,
    crowdfunding_projects_1.usd_pledged,
    crowdfunding_projects_1.backers_count
    
FROM crowdfunding_projects_1
LEFT JOIN   crowdfunding_category ON crowdfunding_projects_1.category_id =   crowdfunding_category.id
LEFT JOIN crowdfunding_location ON crowdfunding_projects_1.location_id = crowdfunding_location.id
LEFT JOIN  crowdfunding_category dcr ON crowdfunding_projects_1.creator_id =  crowdfunding_category.id;

SELECT * FROM crowdfunding_projects_1 LIMIT 10;

SELECT * FROM crowdfunding_projects_1;
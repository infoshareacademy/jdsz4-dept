#!/usr/bin/env python
# coding: utf-8

# In[20]:


# imports

import pandas as pd
import matplotlib.pyplot as plt


# In[21]:


bottom = 9000
upper = 11000
experience_yrs = 44

path_to_file = 'C:/Users/48510/OneDrive/Pulpit/IBMdata.csv'
all_data = pd.read_csv(path_to_file)


# In[22]:


all_data = all_data[(all_data['MonthlyIncome'] > bottom) & (all_data['MonthlyIncome'] < upper)]


# In[23]:


all_data.head()


# In[24]:


all_data.tail()


# In[25]:


print(list(all_data.columns))


# In[26]:


df = all_data[['TotalWorkingYears', 'Department', 'JobRole']]  # extracting 3 columns


# In[27]:


df


# In[28]:


# histogram of total working years

plt.hist(df['TotalWorkingYears'])
plt.show()


# In[29]:


grp_min = df.groupby(['JobRole']).min()
grp_min = grp_min.reset_index()
print(grp_min)


# In[30]:


grp_max = df.groupby(['JobRole']).max()
grp_max = grp_max.reset_index()
print(grp_max)


# In[31]:


df_ranges = pd.DataFrame()

df_ranges['JobRole'] = grp_min['JobRole']
df_ranges['Min'] = grp_min['TotalWorkingYears']
df_ranges['Max'] = grp_max['TotalWorkingYears']


# In[32]:


df_ranges


# In[33]:


adequate_roles = []

for index, row in df_ranges.iterrows():
    
    lower = row['Min']
    role = row['JobRole']
    
    if lower <= experience_yrs:
        
        adequate_roles.append(role)
    


# In[34]:


adequate_roles


# In[35]:


if adequate_roles:
    print('Pozycja dla Ciebie')
    for role in adequate_roles:
        print(role)
else:
    print('masz za mało doświadczenia aby tyle zarabiać')


# In[ ]:





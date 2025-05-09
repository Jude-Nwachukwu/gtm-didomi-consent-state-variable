# Didomi CMP Consent State – GTM Variable Template

This is a Google Tag Manager custom **variable template** designed to work with the **[Didomi Consent Management Platform (CMP)](https://www.didomi.io/)**. It allows you to retrieve the consent state of a specific purpose or vendor and configure tag behavior accordingly.

Use it to:

* Evaluate if a user has granted or denied consent for a specific purpose or vendor.
* Apply blocking triggers in GTM.
* Integrate with GTM even when **Didomi is deployed outside of GTM**.

> 🛠 Developed by **Jude Nwachukwu Onyejekwe** for **[DumbData](https://dumbdata.co/)**



## 🚀 How to Import

1. Open Google Tag Manager and go to the **Templates** section.
2. Click **Variable Templates** → **New**.
3. Open the menu (three dots in the corner) and select **Import**.
4. Upload the `template.tpl` file from this repository.
5. Name and save the variable, e.g., **Didomi CMP Consent State**.

---

## ⚙️ How to Configure

When creating a new variable using this template, you'll see the following fields in the UI:

### **Select Consent State Check Type**

Choose whether you want to check:

* **Consent Purpose State Check**: For a specific consent category.
* **Vendor Consent State**: For a martech vendor like Google, Facebook, etc.

---

### **Insert The Didomi Purpose Category Name**

Used only when checking **Consent Purpose State**.

* Example: `analytics`, `functional`, `market_research`

---

### **Enter Vendor Name**

Used only when checking **Vendor Consent State**.

* Example: `google`, `facebook`, `hotjar`

---

### **Enable Optional Output Transformation**

Check this box to transform consent state values to more readable formats.

When enabled, you'll see these extra fields:

#### **Transform "granted"**

* Choose between:

  * `true`
  * `accept`

#### **Transform "denied"**

* Choose between:

  * `false`
  * `deny`

#### **Also transform "undefined" to "denied"**

* If checked, any unknown or missing value will be treated as `denied`.

---

## 💡 Example Use Cases

### ✅ Blocking Tags Based on Consent

If you want to prevent Google Analytics from firing unless the user consented to "analytics", use:

* Variable: **Didomi CMP Consent State**
* Condition: equals `granted` or `true` or `accept`

OR 

**📢 As an exception trigger, where condition equals `denied` of `false` or `deny`**

### ✅ Consent Mode Integration

When Didomi is implemented **outside of GTM**, this template can still help you:

```js
gtag('consent', 'update', {
  ad_storage: 'granted',  // based on vendor consent state
  analytics_storage: 'denied'
});
```

---

## 🧪 Output Examples

### Purpose: "analytics" → **granted**

```
true
```

### Vendor: "hotjar" → **denied** (transformed)

```
deny
```

---

## 👨‍💻 Author

Made with ❤️ by **[Jude Nwachukwu Onyejekwe](https://www.linkedin.com/in/jude-nwachukwu-onyejekwe/)** for **[DumbData](https://dumbdata.co/)**
Looking for help with GTM or consent setups? [Contact us](https://dumbdata.co/contact-us/)

---

## 📄 License

Licensed under the Apache License 2.0.

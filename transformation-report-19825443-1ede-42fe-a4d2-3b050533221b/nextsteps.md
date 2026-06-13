# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The following steps outline how to validate, test, and deploy the migrated `GadgetsOnline` project.

---

## 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

---

## 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these can indicate areas that may cause runtime issues.

---

## 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element targets the intended modern .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended runtime environment, update it accordingly and re-run `dotnet restore` and `dotnet build`.

---

## 4. Check for Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Verify the following areas manually:

- **`System.Web` dependencies**: These are not available in modern .NET. Ensure any references have been replaced with ASP.NET Core equivalents.
- **`HttpContext` and related types**: Confirm these are sourced from `Microsoft.AspNetCore.Http` and not `System.Web`.
- **`ConfigurationManager`**: If used, ensure it has been replaced with `Microsoft.Extensions.Configuration`.
- **`Global.asax`**: This should have been replaced with `Program.cs` and `Startup.cs` (or the minimal hosting model in .NET 6+).

---

## 5. Validate Application Configuration

- Confirm that `appsettings.json` contains all configuration values that were previously in `Web.config`.
- Verify connection strings are correctly defined under the `ConnectionStrings` section in `appsettings.json`.
- Ensure environment-specific configuration files (e.g., `appsettings.Development.json`) are present if needed.

---

## 6. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

- Navigate to the application URL shown in the terminal output.
- Manually exercise the primary user-facing features (product browsing, cart, checkout, etc.) to confirm basic functionality.
- Check the terminal and browser console for any runtime exceptions or missing resource errors.

---

## 7. Run Existing Tests

If the solution contains test projects, execute them to validate core logic:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

---

## 8. Verify Static Files and Bundling

- Confirm that CSS, JavaScript, and image files are served correctly.
- If the project previously used `System.Web.Optimization` (bundling and minification), ensure it has been replaced with a supported alternative such as `WebOptimizer` or a front-end build tool.

---

## 9. Database Connectivity

- Run the application and perform operations that interact with the database to confirm connection strings and ORM configurations (e.g., Entity Framework) are functioning correctly.
- If using Entity Framework, confirm migrations are up to date:

```bash
dotnet ef database update
```

---

## 10. Review Middleware Pipeline

Open `Program.cs` (or `Startup.cs`) and confirm the middleware pipeline is correctly ordered, including:

- Authentication and Authorization middleware
- Static file serving
- Routing
- Session handling (if applicable)

Incorrect middleware ordering is a common source of runtime issues after migration.
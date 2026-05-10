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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these can indicate areas that may cause runtime issues.

---

## 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to the latest Long-Term Support (LTS) release.

---

## 4. Verify Removed or Changed APIs

Legacy ASP.NET projects often rely on APIs that do not exist in modern .NET. Check the following areas manually:

- **`System.Web` references**: These are not available in .NET Core or later. Ensure all usages have been replaced with their `Microsoft.AspNetCore` equivalents.
- **`HttpContext`**: Verify that access to `HttpContext` is done via dependency injection rather than static access (`HttpContext.Current` is not available).
- **`Global.asax`**: Confirm that any startup logic previously in `Global.asax` has been moved to `Program.cs` or `Startup.cs`.

---

## 5. Check Static Files and wwwroot

Ensure that static assets (CSS, JavaScript, images) have been moved to the `wwwroot` folder, as this is required by ASP.NET Core's static file middleware.

---

## 6. Validate Configuration

- Confirm that `Web.config` settings have been migrated to `appsettings.json`.
- Verify connection strings, app settings, and any environment-specific configuration are present and correctly formatted in `appsettings.json` and/or `appsettings.{Environment}.json`.

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "your-connection-string-here"
  }
}
```

---

## 7. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL shown in the terminal output and verify that the application loads and functions as expected.

---

## 8. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they are failing due to migration-related changes or pre-existing issues.

---

## 9. Database Migrations (If Applicable)

If the project uses Entity Framework, verify that migrations are compatible with the updated version:

```bash
dotnet ef database update
```

If migrations fail, inspect the migration files for any incompatible code and update accordingly.

---

## 10. Publish the Application

Once validation is complete, publish the application to a target directory:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all required files are present before deploying to the target environment.
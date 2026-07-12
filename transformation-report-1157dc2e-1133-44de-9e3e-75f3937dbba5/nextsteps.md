# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Confirm that the output reports `0 Error(s)` and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- `System.Web` dependencies, which are not available in cross-platform .NET. If any remain, they may have been stubbed or replaced during transformation and should be reviewed.
- Windows-specific APIs (registry access, Windows identity, etc.) that may compile but fail at runtime on non-Windows platforms.
- Any use of `HttpContext`, session state, or membership providers, which have different implementations in ASP.NET Core.

### 5. Run the Application Locally

Start the application and verify basic functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core workflows such as browsing products, adding items to a cart, and completing a purchase if applicable.

### 6. Execute Existing Tests

If a test project exists in the solution, run it to validate business logic:

```bash
dotnet test
```

Review results for any failures that may indicate runtime behavioral differences introduced by the migration.

### 7. Review Static Files and Razor Views

If the project uses Razor views or static assets, verify:

- Views render correctly and do not reference removed HTML helpers or deprecated tag helpers.
- Static files (CSS, JavaScript, images) are served correctly and are located under the `wwwroot` folder as expected by ASP.NET Core.

### 8. Validate Configuration

Confirm that application configuration has been migrated from `Web.config` to `appsettings.json` or environment variables. Check that:

- Connection strings are present and correct.
- Application settings keys referenced in code exist in the new configuration structure.
- Any `Web.config` transforms have been accounted for in the new configuration approach.

### 9. Test Database Connectivity

If the application uses a database, verify:

- The connection string points to the correct database instance.
- Migrations or schema scripts have been applied if using Entity Framework.
- Basic CRUD operations function correctly at runtime.

### 10. Publish the Application

Once local validation is complete, publish the application to confirm the output is complete:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present, then deploy the output to your target hosting environment.
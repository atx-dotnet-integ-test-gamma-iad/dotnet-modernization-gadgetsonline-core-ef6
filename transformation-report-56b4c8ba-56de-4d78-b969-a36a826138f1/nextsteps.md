# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore and Build the Solution

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build
```

Verify that both commands complete with no errors or warnings that could indicate missing packages or unresolved references.

### 2. Review Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the following:

- The `<TargetFramework>` element targets a supported cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`).
- No legacy framework references remain (e.g., `net48` or `net472`).
- NuGet package references have been updated to versions compatible with the target framework.

### 3. Check for Removed or Incompatible APIs

Even without build errors, some APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the following areas:

- Any usage of `System.Web` (not available in cross-platform .NET; should be replaced with ASP.NET Core equivalents).
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages should reference `Microsoft.AspNetCore.Http` types.
- Configuration APIs (`System.Configuration.ConfigurationManager`) should be replaced with `Microsoft.Extensions.Configuration`.
- Any Windows-specific APIs (e.g., registry access, WMI) that may compile but fail at runtime on non-Windows platforms.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

- Navigate through the application's primary workflows (browsing products, cart, checkout if applicable) and confirm expected behavior.
- Check the console output for any runtime exceptions or deprecation warnings.

### 5. Review Application Logs

After running the application, inspect any log output for:

- Unhandled exceptions.
- Middleware configuration warnings (e.g., incorrect ordering of `app.Use...` calls).
- Database connectivity issues if Entity Framework or another ORM is in use.

### 6. Database and Data Access Validation

If the project uses Entity Framework:

- Confirm the EF Core package version is compatible with the target framework.
- Run any pending migrations:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

- Validate that all queries return expected results by exercising the data access layer through the application or unit tests.

### 7. Run Existing Tests

If a test project exists in the solution, execute the tests to confirm no regressions were introduced during migration:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by API changes introduced during the migration.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj -c Release -o ./publish
```

Inspect the `./publish` output folder to confirm all required files, static assets, and configuration files are present before deploying to the target environment.
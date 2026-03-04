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
dotnet build --configuration Release
```

Verify that the output reports `0 Error(s)` and `0 Warning(s)` (or review any warnings that may still be present).

### 2. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported, non-end-of-life version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` (the current LTS release).

### 3. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate to the application in a browser and exercise the core functionality manually to confirm expected behavior.

### 4. Execute the Test Suite

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test --configuration Release --logger "console;verbosity=detailed"
```

Review the test output and ensure all tests pass. Investigate and resolve any failures before proceeding.

### 5. Check for Removed or Changed APIs

Even with a successful build, runtime behavior may differ from the legacy .NET Framework version. Pay particular attention to:

- **`System.Web` dependencies** — These do not exist in cross-platform .NET. Confirm any HTTP context, session, or request/response handling has been replaced with ASP.NET Core equivalents.
- **`App.config` / `Web.config`** — Configuration in cross-platform .NET is handled via `appsettings.json` and `IConfiguration`. Verify all configuration values are being read correctly at runtime.
- **Entity Framework** — If the project uses Entity Framework, confirm it has been migrated to Entity Framework Core and that database migrations are functioning correctly.
- **Authentication/Authorization** — Confirm any membership or identity providers have been replaced with ASP.NET Core Identity or equivalent middleware.

### 6. Validate Database Connectivity

If the application uses a database, confirm the connection string in `appsettings.json` is correct for the target environment and that the application can connect and perform queries successfully.

### 7. Review Static Files and Bundling

Confirm that static assets (CSS, JavaScript, images) are being served correctly. In ASP.NET Core, static files are served from the `wwwroot` folder. Verify that all front-end assets have been placed there and that `app.UseStaticFiles()` is present in the middleware pipeline.

### 8. Publish the Application

Once local validation is complete, publish the application to a target folder:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` folder and confirm all expected files are present.

### 9. Deploy to the Target Environment

Copy the published output to the target server or hosting environment. Confirm the correct .NET runtime version is installed on the host:

```bash
dotnet --list-runtimes
```

Start the application and perform a final round of smoke testing against the deployed instance to confirm it is operating correctly.